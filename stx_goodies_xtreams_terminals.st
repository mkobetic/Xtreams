'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#BlockClosureGenerateStream
	instanceVariableNames:'process current contentsSpecies writing readingSemaphore
		writingSemaphore closed'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BlockClosureGenerateStream comment:'Read stream on a one argument block, evaluates the block once for the life time of the stream. Once the block finishes execution, the stream is closed. The block is expected to write to the block argument, which will block exectuion until elements are read from the stream.
{{{
	"In this example, we have a -hard- loop, not using collection protocol, which will only run one element at a time."
	[:out | 1 to: 10 do: [:i | out put: i]] reading read: 5.
}}}
{{{
	"Fibonacci"
	[:out | | a b x |
	a := 0. b := 1.
	[out put: a.
	x := a.
	a := b.
	b := b + x] repeat] reading ++ 500; get.
}}}

Instance Variables
	current	<Object>	the current element in the stream
	closed	<Boolean>	true if the block has finished execution
	contentsSpecies	<Class>	species for collections of elements of this stream
	process	<Process>	the process executing the block
	readingSemaphore	<Semaphore>	attempts to read will wait on this
	writingSemaphore	<Semaphore>	attempts to write will wait on this, signaled when an attempt to read is performed

'
!


!BlockClosureGenerateStream methodsFor:'accessing'!

get
	writingSemaphore signal.
	closed ifTrue: [Incomplete zero raise].
	readingSemaphore wait.
	^current
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger] whileTrue:
		[aSequenceableCollection at: startIndex + count put: self get.
		count := count + 1]]
			on: Incomplete do: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!BlockClosureGenerateStream methodsFor:'initialize-release'!

close
	closed := true.
	process terminate.
	readingSemaphore signal
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

on: aBlockClosure
	super on: aBlockClosure.
	contentsSpecies := Array.
	readingSemaphore := Semaphore new.
	writingSemaphore := Semaphore new.
	closed := false.
	process :=
		[aBlockClosure value: [:in |
			writingSemaphore wait.
			current := in.
			readingSemaphore signal] writing.
		closed := true] fork
! !

!BlockClosureGenerateStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BlockClosureGenerateStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#SequenceableCollectionReadStream
	instanceVariableNames:'position'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

SequenceableCollectionReadStream comment:'Read stream on a sequenceable collection.
{{{
	(1 to: 10000) reading ++ 1000; read: 5
}}}

Instance Variables
	position	<Integer> current position of the stream

'
!


!SequenceableCollectionReadStream methodsFor:'accessing'!

get
	position = source size ifTrue: [Incomplete zero raise].
	position := position + 1.
	^source at: position
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	aSequenceableCollection replaceFrom: startIndex to: startIndex + count - 1 with: source startingAt: position + 1.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!SequenceableCollectionReadStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^source species
!

on: aSequenceableCollection
	super on: aSequenceableCollection.
	position := 0
! !

!SequenceableCollectionReadStream methodsFor:'printing'!

streamingPrintOn: aStream
	| tail head |
	super streamingPrintOn: aStream.
	tail := position min: 5.
	head := (source size - position) min: (10 - tail).
	aStream
		write: ' position: ';
		print: position;
		write: ' size: ';
		print: source size;
		cr; tab;
		write: (position > 5 ifTrue: ['...'] ifFalse: ['']);
		print: (source copyFrom: position + 1 - tail to: position);
		write: '  |  ';
		print: (source copyFrom: position + 1 to: position + head);
		write: (source size - position > (10 - tail) ifTrue: ['...'] ifFalse: [''])
! !

!SequenceableCollectionReadStream methodsFor:'private'!

streamingInsert: anInteger into: aWriteStream
	| count |
	anInteger isZero ifTrue: [^self].
	count := anInteger min: self available.
	aWriteStream insert: count from: source at: position + 1.
	position := position + count.
	count >= anInteger ifTrue: [^self].
	(Incomplete on: source count: count at: position - count + 1) raise
!

streamingInsertInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [Incomplete zero raise].
	self streamingInsert: count into: aWriteStream.
	^count
!

streamingWrite: anInteger into: aWriteStream
	| count |
	anInteger isZero ifTrue: [^0].
	count := anInteger min: self available.
	aWriteStream write: count from: source at: position + 1.
	position := position + count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete on: source count: count at: position - count + 1) raise
!

streamingWriteInto: aWriteStream
	| count |
	(count := self available) isZero ifTrue: [^self].
	self streamingWrite: count into: aWriteStream.
	^count
! !

!SequenceableCollectionReadStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

length
	^source size
!

position
	" Return a bookmark for the current stream state. "

	^position
!

position: aPosition

	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition min: self length.
	position = aPosition ifTrue: [^aPosition ].
	(Incomplete count: position) raise
! !

!SequenceableCollectionReadStream methodsFor:'testing'!

isPositionable
	^true
! !

!SequenceableCollectionReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__SequenceableCollectionReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#ExternalWriteStream
	instanceVariableNames:'contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

ExternalWriteStream comment:'Used to write to BlockableIOAccessors (e.g sockets or pipes). This is a binary stream (consumes bytes/ByteArrays).

{{{
	[ :in :out |
		[	out writing write: ''Hello''; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: SocketAccessor openPair
}}}
{{{
	[ :in :out |
		[	out writing write: ''Hello''; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: OSSystemSupport concreteClass pipeAccessorClass openPair
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream

'
!


!ExternalWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[wrote := destination writeFrom: aSequenceableCollection startingAt: startIndex + count for: anInteger - count.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote].
	^anInteger
! !

!ExternalWriteStream methodsFor:'initialize-release'!

close
	destination isActive ifFalse: [^self].
	destination close
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

flush
	destination isActive ifFalse: [^self].
	destination commit
!

on: anAccessor
	super on: anAccessor.
	contentsSpecies := ByteArray
! !

!ExternalWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ExternalWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#BufferWriteStream
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BufferWriteStream comment:'Write stream on a Buffer. Usually used in tandem with a read stream to access buffer contents conveniently.
{{{
	buffer := ElasticBuffer on: String new.
	bufferIn := buffer writing.
	bufferOut := buffer reading.
	100000 timesRepeat: [ bufferIn write: ''Hello World''. bufferOut read: 11 ].
	buffer cacheSize  
}}}
'
!


!BufferWriteStream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	^destination insert: anInteger from: aSequenceableCollection at: startIndex
!

put: anObject
	^destination put: anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	^destination write: anInteger from: aSequenceableCollection at: startIndex
! !

!BufferWriteStream methodsFor:'initialize-release'!

close
	destination close
!

contentsSpecies
	^destination contentsSpecies
!

flush
! !

!BufferWriteStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := destination writeSkip: anInteger.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (destination writeSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

available
	^destination writeSize
!

length
	^destination activeSize
!

position
	^destination writePosition
!

position: aPosition
	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: destination activeSize.
	destination writePosition: available.
	available = aPosition ifTrue: [^aPosition ].
	(Incomplete count: available) raise
!

skip: anInteger
	| count |
	count := destination writeSkip: anInteger.
	count ~= anInteger ifTrue: [(Incomplete count: count) raise]
! !

!BufferWriteStream methodsFor:'testing'!

isPositionable
	^true
! !

!BufferWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BufferWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#BufferedWriteStream
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BufferedWriteStream comment:'Wraps a stream and buffers output to it based on the size of the ring-buffer it has. This is useful for doing "burst" writing, where you know exactly when you can flush the stream. To force the buffer to the underlying stream, use #flush.

Instance Variables
	buffer  <RingBuffer>    a fixed size RingBuffer to buffer up output, released when it is full or #flush/#close is sent.

'
!


!BufferedWriteStream class methodsFor:'instance creation'!

on: aDestination bufferSize: bufferSize
	^self new on: aDestination bufferSize: bufferSize
! !

!BufferedWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[[amount := buffer write: (buffer writeSize min: (anInteger - count)) from: aSequenceableCollection at: startIndex + count.
	count := count + amount.
	count < anInteger] whileTrue: [self flush]]
		on: Incomplete do: [:exception | (Incomplete on: aSequenceableCollection count: count + exception count at: startIndex) raise].
	^anInteger
! !

!BufferedWriteStream methodsFor:'initialize-release'!

close
	super close.
	buffer recycle.
	buffer := nil
!

contentsSpecies
	^destination contentsSpecies
!

flush
	destination write: buffer
!

on: aDestination bufferSize: bufferSize
	buffer := RingBuffer new: bufferSize class: aDestination contentsSpecies.
	super on: aDestination
! !

!BufferedWriteStream methodsFor:'printing'!

streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		write: ' buffered: ';
		print: buffer writeSize.
	buffer writeSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsPast
! !

!BufferedWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BufferedWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#SharedQueueWriteStream
	instanceVariableNames:'contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

SharedQueueWriteStream comment:'Write stream on a SharedQueue. Primarily used for data transfer between processes.
{{{
	queue := SharedQueue new.
	in := queue reading.
	out := queue writing.
	received := Array new writing.
	done := Semaphore new.
	consumer :=	
		[ | size |
			[	(size := in get) isZero
			] whileFalse: [ | word |
				word := ByteString new: size.
				in read: size into: word.
				received put: word ].
			done signal.
		] fork.
	#(one two three four) do: [ :word | out put: word size; write: word ].
	out put: 0.
	done wait.
	received conclusion
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream

'
!


!SharedQueueWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | destination nextPut: (aSequenceableCollection at: index)].
	^anInteger
! !

!SharedQueueWriteStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

flush
!

on: aDestination
	super on: aDestination.
	contentsSpecies := Array
! !

!SharedQueueWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__SharedQueueWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#BlockClosureWriteStream
	instanceVariableNames:'contentsSpecies closeBlock'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BlockClosureWriteStream comment:'Write stream on a single argument block, the block is evaluated for each element written with the element assigned as the argument of the evaluation.
{{{
	"Transcript as an xtream"
	[ :x | Transcript nextPut: x ] writing write: ''Hello World!!''
}}}
{{{
	"/dev/null"
	[ :x | ] writing write: ''Hello World!!''
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream
	closeBlock	<BlockClosure> invoked in response to the #close message, allows customizing the close behavior

'
!


!BlockClosureWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger] whileTrue:
		[destination value: (aSequenceableCollection at: startIndex + count).
		count := count + 1]]
			on: Incomplete do: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!BlockClosureWriteStream methodsFor:'initialize-release'!

close
	closeBlock cull: self
!

closeBlock
	^closeBlock
!

closeBlock: aBlock
	closeBlock := aBlock
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: anObject
	contentsSpecies := anObject
!

flush
!

on: aBlockClosure
	super on: aBlockClosure.
	contentsSpecies := Array.
	closeBlock := []
! !

!BlockClosureWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BlockClosureWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#PointerReadStream
	instanceVariableNames:'length contentsSpecies position'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals'
!

PointerReadStream comment:'Read stream on external heap, commonly used to unmarshal output or an external library call. The terminal is a CPointer and its associated CType is used to interpret the bytes on the heap. The length of the stream should be set, to avoid reading past the allocated memory space.
{{{
	| buffer |
	buffer := CIntegerType unsignedChar malloc: 50.
	[	buffer writing
			length: 50;
			write: ''Hello World!!''.
		buffer reading
			length: 12;
			contentsSpecies: ByteString;
			rest
	] ensure: [ buffer free ]
}}}

Instance Variables
	length	<Integer> allocated size of the stream as a number of elements of associated CType
	contentsSpecies	<Class> species for collections of elements of this stream
	position	<Integer> current position of the stream

'
!


!PointerReadStream methodsFor:'accessing'!

get
	| object |
	(length isNil or: [ position < length ]) ifFalse: [ Incomplete zero raise ].
	object := source at: position.
	position := position + 1.
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex
	
	| count |
	count := self available ifNil: [ anInteger ] ifNotNil: [ :available | available min: anInteger ].
	source type referentType = UnsignedChar
		ifTrue: [ source copyAt: position to: aSequenceableCollection size: anInteger startingAt: startIndex. ]
		ifFalse: [ startIndex to: startIndex + count - 1 do: [ :i | aSequenceableCollection at: i put: self get ] ].
	position := position + count.
	^count < anInteger
		ifTrue: [ (Incomplete on: aSequenceableCollection count: count at: startIndex) raise ]
		ifFalse: [ count ]
! !

!PointerReadStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

length: anObject
	length := anObject
!

on: aPointer
	super on: aPointer.
	contentsSpecies := Array.
	position := 0
! !

!PointerReadStream methodsFor:'private'!

streamingInsertInto: aWriteStream
	^length
		ifNil: [ self error: 'Cannot stream from an unbounded stream' ]
		ifNotNil: [ super streamingInsertInto: aWriteStream ]
!

streamingWriteInto: aWriteStream
	^length
		ifNil: [ self error: 'Cannot stream from an unbounded stream' ]
		ifNotNil: [ super streamingWriteInto: aWriteStream ]
! !

!PointerReadStream methodsFor:'seeking'!

++ anInteger

	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available ifNil: [ anInteger ] ifNotNil: [ :available | available min: anInteger ].
	position := position + anInteger.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

available

	^self length ifNotNil: [ super available ]
!

length
	^length
!

position
	^position
!

position: aPosition

	aPosition < 0 ifTrue: [Incomplete zero raise].
	length ifNil: [ ^position := aPosition ].
	aPosition > length ifFalse: [ ^position := aPosition ].
	position := length.
	^(Incomplete count: length) raise
! !

!PointerReadStream methodsFor:'testing'!

isPositionable
	^true
! !

!PointerReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PointerReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

LibraryDefinition subclass:#stx_goodies_xtreams_terminals
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_terminals class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 17 2011-11-21 06:03:03Z mkobetic $'
! !

!stx_goodies_xtreams_terminals class methodsFor:'description'!

excludedFromPreRequisites
    "list all packages which should be ignored in the automatic
     preRequisites scan. See #preRequisites for more."

    ^ #(
    )
!

preRequisites
    "list all required packages.
     This list can be maintained manually or (better) generated and
     updated by scanning the superclass hierarchies and looking for
     global variable accesses. (the browser has a menu function for that)
     Howevery, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPrerequisites method."

    ^ #(
        #'stx:goodies/xtreams/core'    "Xtreams::ReadStream - superclass of Xtreams::BlockClosureReadStream "
        #'stx:libbasic'    "NonPositionableExternalStream - superclass of extended Socket "
        #'stx:libbasic2'    "Queue - superclass of extended SharedQueue "
        #'stx:libcompat'    "IOAccessor - referenced by Filename>>reading "
        #'stx:libview'    "GraphicsContext - superclass of extended View "
        #'stx:libwidg'    "TextView - superclass of extended TextCollector "
    )
! !

!stx_goodies_xtreams_terminals class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'Xtreams::BlockClosureGenerateStream'
        #'Xtreams::BlockClosureReadStream'
        #'Xtreams::BlockClosureWriteStream'
        #'Xtreams::BufferReadStream'
        #'Xtreams::BufferWriteStream'
        #'Xtreams::BufferedWriteStream'
        #'Xtreams::CollectionWriteStream'
        #'Xtreams::ExternalReadStream'
        #'Xtreams::ExternalWriteStream'
        #'Xtreams::FileWriteStream'
        #'Xtreams::NullWriteStream'
        #'Xtreams::PointerReadStream'
        #'Xtreams::PointerWriteStream'
        #'Xtreams::SequenceableCollectionReadStream'
        #'Xtreams::SequenceableCollectionWriteStream'
        #'Xtreams::SharedQueueReadStream'
        #'Xtreams::SharedQueueWriteStream'
        #'stx_goodies_xtreams_terminals'
        #'Xtreams::FileReadStream'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        Block reading
        Block writing
        Collection writing
        Filename appending
        Filename reading
        Filename writing
        Random reading
        SequenceableCollection reading
        SequenceableCollection writing
        SharedQueue reading
        SharedQueue writing
        Socket accepting
        Socket reading
        Socket writing
        TextCollector writing
        UndefinedObject writing
        #'Xtreams::Buffer' reading
        #'Xtreams::Buffer' writing
        #'Xtreams::WriteStream' buffering:
    )
! !

!stx_goodies_xtreams_terminals class methodsFor:'description - project information'!

applicationIconFileName
    "Return the name (without suffix) of an icon-file (the app's icon); will be included in the rc-resource file"

    ^ nil
    "/ ^ self applicationName
!

companyName
    "Return a companyname which will appear in <lib>.rc"

    ^ 'eXept Software AG'
!

description
    "Return a description string which will appear in vc.def / bc.def"

    ^ 'Smalltalk/X Class library'
!

legalCopyright
    "Return a copyright string which will appear in <lib>.rc"

    ^ 'Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011'
!

productName
    "Return a product name which will appear in <lib>.rc"

    ^ 'Smalltalk/X'
! !

!stx_goodies_xtreams_terminals class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/terminals/stx_goodies_xtreams_terminals.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'32'"$"
! !

!stx_goodies_xtreams_terminals class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_terminals.st 17 2011-11-21 06:03:03Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#FileWriteStream
	instanceVariableNames:'position isPositionable contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

FileWriteStream comment:'Writes to a file. File write streams can be created via the usual #writing message or via #appending which opens the file in appending mode. In appending mode, you cannot position the stream before the end of the file contents, so you can never overwrite existing contents. In writing mode, the file will be truncated at stream''s current position when #close is called. To keep the entire contents of the file, use -= 0 to skip to the end before closing. This behavior is different from the classic streams which would erase the contents of the file on opening. The stream is binary and naturally positionable.
{{{
	| file |
	file := ''/dev/shm/xtreams-test'' asFilename.
	[	file writing write: ''Hello''; close.
		file appending write: '' World!!''; close.
		file contentsOfEntireFile.
	] ensure: [ file delete ]
}}}
It is also possible to send #reading or #writing to a pre-opened IOAcccessor if some other opening mode configuration is desirable. For example to emulate the classic write stream opening behavior, you can use the following:
{{{
	(IOAccessor openFileNamed: ''/dev/shm/xtreams-test'' 
		direction: IOAccessor writeOnly
		creation: IOAccessor truncateOrCreate
	) writing close
}}}

Instance Variables
	position	<Integer> current position of the stream
	isPositionable	<Boolean> indicates that the file is open in append mode
	contentsSpecies	<Class> species for collections of elements of this stream

'
!


!FileWriteStream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	^self shouldNotImplement.

	"While it might seem desireable to be able to insert in to a file, the reality is you can only do so if you can read and write to the file. if you can read and write to the file, the fileSize becomes indeterminate. The only reasonable way to insert in to a file is to memory map it and access it with a PointerWriteStream instead."
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[wrote := destination writeFrom: aSequenceableCollection startingAt: startIndex + count for: anInteger.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote.
		position := position + wrote].
	^anInteger
! !

!FileWriteStream methodsFor:'initialize-release'!

close
	destination isActive ifFalse: [^self].
	destination truncateTo: position.
	destination close
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

flush
	destination isActive ifFalse: [^self].
	destination commit
!

isPositionable: aBoolean
	"Only set to false when the file is open in append mode."

	isPositionable := aBoolean
!

on: anAccessor
	super on: anAccessor.
	contentsSpecies := ByteArray.
	isPositionable := true.
	position := 0
! !

!FileWriteStream methodsFor:'seeking'!

++ anInteger
	| count |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	destination seekTo: position.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	destination seekTo: position.
	anInteger = count ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

length
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^destination fileSize
!

position
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^position
!

position: aPosition
	| available |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	destination seekTo: available.
	position := available.
	available = aPosition ifTrue: [ ^aPosition ].
	(Incomplete count: available) raise
! !

!FileWriteStream methodsFor:'testing'!

isPositionable
	^isPositionable
! !

!FileWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__FileWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#SequenceableCollectionWriteStream
	instanceVariableNames:'position length'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals'
!

SequenceableCollectionWriteStream comment:'Write stream on a sequenceable collection. The collection is grown automatically to accommodate any elements written. Closing a collection write stream will truncate the collection to the current stream position. This behavior is useful as a replacement for the traditional #contents message. The contents can be accessed with the #terminal message after the stream is closed.
{{{
	String new writing write: ''Hello World''; -- 6; close; terminal
}}}

Instance Variables
	position	<Integer> current position of the stream
	length	<Integer> number of valid elements in the destination

'
!


!SequenceableCollectionWriteStream methodsFor:'accessing'!

contents
	^destination copyFrom: 1 to: position
!

insert: anInteger from: aSequenceableCollection at: startIndex
        destination := destination copyGrownToAtLeast: destination size + anInteger.
        destination replaceFrom: position + anInteger + 1 to: length + anInteger with: destination startingAt: position + 1.
        destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
        position := position + anInteger.
        length := length + anInteger.
        ^anInteger
!

put: anObject
        | free |
        free := destination size - position.
        free < 1 ifTrue: [destination := destination copyGrownToAtLeast: destination size + 1].
        position := position + 1.
        destination at: position put: anObject.
        length := length + 1.
        ^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
        | available |
        available := destination size - position.
        available < anInteger ifTrue: [destination := destination copyGrownToAtLeast: destination size + anInteger - available].
        destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
        position := position + anInteger.
        position > length ifTrue: [length := position].
        ^anInteger
! !

!SequenceableCollectionWriteStream methodsFor:'initialize-release'!

close
        destination := destination copyFrom: 1 to: position
!

contentsSpecies
	^destination species
!

flush
!

on: aSequenceableCollection
	super on: aSequenceableCollection.
	position := 0.
	length := 0
! !

!SequenceableCollectionWriteStream methodsFor:'printing'!

streamingPrintOn: aStream
	| tail head |
	super streamingPrintOn: aStream.
	tail := position min: 5.
	head := (destination size - position) min: (10 - tail).
	aStream
		write: ' position: ';
		print: position;
		write: ' size: ';
		print: destination size;
		cr; tab;
		write: (position > 5 ifTrue: ['...'] ifFalse: ['']);
		print: (destination copyFrom: position + 1 - tail to: position);
		write: '  |  ';
		print: (destination copyFrom: position + 1 to: position + head);
		write: (destination size - position > (10 - tail) ifTrue: ['...'] ifFalse: [''])
! !

!SequenceableCollectionWriteStream methodsFor:'private'!

streamingInsert: anInteger from: aStreamable
        | reading |
        reading := aStreamable reading.
        destination := destination copyGrownToAtLeast: destination size + anInteger.
        destination replaceFrom: position + anInteger to: destination size with: destination startingAt: position.
        [reading read: anInteger into: destination at: position + 1]
                on: Incomplete do: [:error | position := position + error count. error pass].
        position := position + anInteger
!

streamingInsertFrom: aStreamable
	self error: 'Not Yet Implemented'
!

streamingWrite: anInteger from: aReadStream
        | available |
        available := destination size - position.
        available < anInteger ifTrue: [destination := destination copyGrownToAtLeast: destination size + anInteger - available].
        [aReadStream read: anInteger into: destination at: position + 1]
                on: Incomplete do: [:error |
                        position := position + error count.
                        position > length ifTrue: [length := position].
                        error pass].
        position := position + anInteger.
        position > length ifTrue: [length := position].
        ^anInteger
!

streamingWriteFrom: aReadStream
        | available count chunkSize |
        count := 0.
        chunkSize := DefaultBufferSize.
        ^[[available := destination size - position.
        available < chunkSize ifTrue: [destination := destination copyGrownToAtLeast: destination size + chunkSize].
        aReadStream read: chunkSize into: destination at: position + 1.
        position := position + chunkSize.
        count := count + chunkSize] repeat]
                on: Incomplete do: [:exception |
                        position := position + exception count.
                        position > length ifTrue: [length := position].
                        count + exception count]
! !

!SequenceableCollectionWriteStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

length
	^length
!

position
	^position
!

position: aPosition
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition min: self length.
	position = aPosition ifTrue: [^aPosition].
	(Incomplete count: position) raise
! !

!SequenceableCollectionWriteStream methodsFor:'testing'!

isPositionable
	^true
! !

!SequenceableCollectionWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__SequenceableCollectionWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#NullWriteStream
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!


!NullWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex
	^anInteger
! !

!NullWriteStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^Array
!

flush
! !

!NullWriteStream methodsFor:'private'!

streamingInsert: anInteger from: aReadStream
	aReadStream ++ anInteger
!

streamingInsertFrom: aReadStream
	aReadStream -= 0
!

streamingWrite: anInteger from: aReadStream
	aReadStream ++ anInteger
!

streamingWriteFrom: aReadStream
	aReadStream -= 0
! !

!NullWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__NullWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#ExternalReadStream
	instanceVariableNames:'cache cachePosition cacheDataSize'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals'
!

ExternalReadStream comment:'Used to read from BlockableIOAccessors (e.g sockets or pipes). Elements are read-ahead but only what''s available. This is a binary stream (produces bytes/ByteArrays).

{{{
	[ :in :out |
		[	out writing write: ''Hello''; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: SocketAccessor openPair
}}}
{{{
	[ :in :out |
		[	out writing write: ''Hello''; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: OSSystemSupport concreteClass pipeAccessorClass openPair
}}}

Instance Variables
	cache	<ByteArray | ByteString> read-ahead buffer
	cachePosition	<SmallInteger> position in the buffer
	cacheDataSize	<SmallInteger> size of valid data in the buffer

'
!


!ExternalReadStream methodsFor:'accessing'!

get
	cachePosition < cacheDataSize ifFalse: [
		cachePosition := 0.
		cacheDataSize := (1 max: self bytesForRead) min: cache size.
		cacheDataSize := source readInto: cache startingAt: 1 for: cacheDataSize.
		cacheDataSize isZero ifTrue: [ self incompleteRead: Incomplete zero ] ].
	^cache at: (cachePosition := cachePosition + 1)
!

read: anInteger into: aSequenceableCollection at: startIndex

	| index toRead |
	anInteger isZero ifTrue: [^0].
	index := startIndex.
	toRead := anInteger.
	[toRead > 0] whileTrue: [ | amount |
		cachePosition < cacheDataSize ifFalse: [
			cachePosition := 0.
			cacheDataSize := (toRead max: self bytesForRead) min: cache size.
			cacheDataSize := source readInto: cache startingAt: 1 for: cacheDataSize.
			cacheDataSize isZero ifTrue: [ self incompleteRead: (Incomplete on: aSequenceableCollection count: anInteger - toRead at: startIndex) ] ].
		amount := (cacheDataSize - cachePosition) min: toRead.
		aSequenceableCollection replaceFrom: index to: index + amount - 1 with: cache startingAt: cachePosition + 1.
		cachePosition := cachePosition + amount.
		index := index + amount.
		toRead := toRead - amount ].
	^anInteger
! !

!ExternalReadStream methodsFor:'initialize-release'!

close
	super close.
	cache recycle
!

contentsSpecies
	^cache class
!

contentsSpecies: aClass
        cache ifNotNil: [ cache recycle ].
        cache := aClass newRecycled: DefaultBufferSize.
        cachePosition := 0.
        cacheDataSize := 0.
!

on: anAccessor
	super on: anAccessor.
	self contentsSpecies: ByteArray
! !

!ExternalReadStream methodsFor:'private'!

bytesForRead

	^source bytesForRead
!

incompleteRead: incomplete

	incomplete raise
! !

!ExternalReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ExternalReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#CollectionWriteStream
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

CollectionWriteStream comment:'Write stream on a sequenceable collection. The collection is grown automatically to accommodate any elements written. Closing a collection write stream will truncate the collection to the current stream position. This behavior is useful as a replacement for the traditional #contents message. The contents can be accessed with the #terminal message after the stream is closed.
{{{
	String new writing write: ''Hello World''; -- 6; close; terminal
}}}

Instance Variables
	position	<Integer> current position of the stream
	length	<Integer> number of valid elements in the destination

'
!


!CollectionWriteStream methodsFor:'accessing'!

put: anObject
	destination add: anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index |
		destination add: (aSequenceableCollection at: index)].
	^anInteger
! !

!CollectionWriteStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^destination species
!

flush
! !

!CollectionWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__CollectionWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#BufferReadStream
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BufferReadStream comment:'Read stream on a Buffer. Usually used in tandem with a write stream to access buffer contents conveniently.
{{{
	buffer := ElasticBuffer on: String new.
	bufferIn := buffer writing.
	bufferOut := buffer reading.
	100000 timesRepeat: [ bufferIn write: ''Hello World''. bufferOut read: 11 ].
	buffer cacheSize  
}}}
'
!


!BufferReadStream methodsFor:'accessing'!

get
	^source get
!

read: anInteger into: aSequenceableCollection at: startIndex
	source read: anInteger into: aSequenceableCollection at: startIndex.
	^anInteger
! !

!BufferReadStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^source contentsSpecies
! !

!BufferReadStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := source readSkip: anInteger.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := (source readSkip: anInteger negated) negated.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

available
	^source readSize
!

length
	^source activeSize
!

position
	^source readPosition
!

position: aPosition
	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: source activeSize.
	source readPosition: available.
	available = aPosition ifTrue: [^aPosition ].
	(Incomplete count: available) raise
! !

!BufferReadStream methodsFor:'testing'!

isPositionable
	^true
! !

!BufferReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BufferReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#PointerWriteStream
	instanceVariableNames:'length position contentsSpecies'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals'
!

PointerWriteStream comment:'Write stream on external heap, commonly used to marshal input for an external library call. The terminal is a CPointer and its associated CType is used to interpret the bytes on the heap. The length of the stream must be set, to avoid writing past the allocated memory space. If more objects are written than can fit in the pre-allocated space, a new larger heap chunk is automatically allocated to accommodate it (the contents of the old chunk are copied over and the chunk is deallocated). Similarly closing the write stream will reallocate and shrink the write stream to its position at that time.
{{{
	| buffer |
	buffer := CIntegerType unsignedChar malloc: 50.
	[	buffer writing
			length: 50;
			write: ''Hello World!!''.
		buffer reading
			length: 12;
			contentsSpecies: ByteString;
			rest
	] ensure: [ buffer free ]
}}}

Instance Variables
	length	<Integer> allocated size of the stream as a number of elements of associated CType
	position	<Integer> current position of the stream
	contentsSpecies	<Class> species for collections of elements of this stream

'
!


!PointerWriteStream methodsFor:'accessing'!

contents
	| cache |
	cache := self contentsSpecies withSize: position.
	destination copyAt: 0 to: cache size: position startingAt: 1.
	^cache
!

insert: anInteger from: aSequenceableCollection at: startIndex
	| shift |
	shift := length - position.
	self resizeTo: length + anInteger.
	OSSystemSupport concreteClass new copyMemoryTo: destination + position + anInteger from: destination + position size: shift.
	self copyFrom: aSequenceableCollection size: anInteger startingAt: startIndex.
	position := position + anInteger.
	^anInteger
!

put: anObject
	| free |
	free := length - position.
	free < 1 ifTrue: [self resizeTo: length + 1].
	destination at: position put: anObject.
	position := position + 1
!

write: anInteger from: aSequenceableCollection at: startIndex
	| available |
	available := length - position.
	available < anInteger ifTrue: [self resizeTo: length + anInteger - available].
	self copyFrom: aSequenceableCollection size: anInteger startingAt: startIndex.
	position := position + anInteger.
	^anInteger
! !

!PointerWriteStream methodsFor:'initialize-release'!

close
	self resizeTo: position
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

flush
!

length: anObject
	length := anObject
!

on: aPointer
	super on: aPointer.
	contentsSpecies := Array.
	length := 1.
	position := 0
! !

!PointerWriteStream methodsFor:'private'!

copyFrom: aSequenceableCollection size: anInteger startingAt: startIndex

	destination type = UnsignedChar
		ifTrue: [ 	destination copyAt: position from: aSequenceableCollection size: anInteger startingAt: startIndex. ]
		ifFalse: [
			0 to: anInteger - 1 do: [ :i |
				destination at: position + i put: (aSequenceableCollection at: startIndex + i) ] ]
!

resizeTo: anInteger
	| replacement beGC |
	length = anInteger ifTrue: [^self].
	replacement := destination type baseReferentType malloc: anInteger.
	OSSystemSupport concreteClass new copyMemoryTo: replacement from: destination size: (length min: anInteger).
	beGC := CPointer.GarbageCollectablePointers includes: destination.
	destination free.
	destination referentAddress: replacement referentAddress.
	beGC ifTrue: [destination beGarbageCollectable].
	length := anInteger
! !

!PointerWriteStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	count = anInteger ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

length
	^length
!

position
	^position
!

position: aPosition
	" Return to a bookmarked position on this stream. "

	aPosition < 0 ifTrue: [Incomplete zero raise].
	aPosition > length ifFalse: [ ^position := aPosition ].
	position := length.
	^(Incomplete count: length) raise
! !

!PointerWriteStream methodsFor:'testing'!

isPositionable
	^true
! !

!PointerWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PointerWriteStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#SharedQueueReadStream
	instanceVariableNames:'contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

SharedQueueReadStream comment:'Read stream on a SharedQueue. Primarily used for data transfer between processes.
{{{
	queue := SharedQueue new.
	in := queue reading.
	out := queue writing.
	received := Array new writing.
	done := Semaphore new.
	consumer :=	
		[ | size |
			[	(size := in get) isZero
			] whileFalse: [ | word |
				word := ByteString new: size.
				in read: size into: word.
				received put: word ].
			done signal.
		] fork.
	#(one two three four) do: [ :word | out put: word size; write: word ].
	out put: 0.
	done wait.
	received conclusion
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream

'
!


!SharedQueueReadStream methodsFor:'accessing'!

get
	^source next
!

read: anInteger into: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | aSequenceableCollection at: index put: source next].
	^anInteger
! !

!SharedQueueReadStream methodsFor:'initialize-release'!

close
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass
!

on: aSource
	super on: aSource.
	contentsSpecies := Array
! !

!SharedQueueReadStream methodsFor:'private'!

streamingInsertInto: aWriteStream
	self shouldNotImplement
!

streamingWriteInto: aWriteStream
	self shouldNotImplement
! !

!SharedQueueReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__SharedQueueReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ExternalReadStream subclass:#FileReadStream
	instanceVariableNames:'position'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

FileReadStream comment:'Reads from a file. The stream is usually created by sending #reading to a Filename. However the actual terminal is an IOAccessor. The original filename is accessible through the IOAccessor. The stream is binary and is naturally positionable.
{{{
	| file |
	file := ObjectMemory imageName asFilename reading.
	[ file read: 13 ] ensure: [ file close ]
}}}
As a convenience, sending #reading to a Filename of a directory will create a stream of all filenames in that directory.
{{{
	''/tmp'' asFilename reading rest
}}}

Instance Variables
	position	<Integer> current position of the stream

'
!


!FileReadStream methodsFor:'accessing'!

get

	| object |
	object := super get.
	position := position + 1.
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex

	super read: anInteger into: aSequenceableCollection at: startIndex.
	position := position + anInteger.
	^anInteger
! !

!FileReadStream methodsFor:'initialize-release'!

on: anAccessor
	super on: anAccessor.
	position := 0
! !

!FileReadStream methodsFor:'private'!

bytesForRead

	"Ideally we'd ask for the fileSize and subtract that from our position, but calling #fileSize is a slow primitive"
	^cache size
!

incompleteRead: incomplete

	position := position + incomplete count.
	super incompleteRead: incomplete.
! !

!FileReadStream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	source seekTo: position.
	cacheDataSize := cachePosition := 0.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	source seekTo: position.
	cacheDataSize := cachePosition := 0.
	anInteger = count ifTrue: [^anInteger].
	(Incomplete count: count) raise
!

length
	^source fileSize
!

position
	^position
!

position: aPosition

	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	source seekTo: available.
	position := available.
	cacheDataSize := cachePosition := 0.
	available = aPosition ifTrue: [^aPosition].
	(Incomplete count: available) raise
! !

!FileReadStream methodsFor:'testing'!

isPositionable
	^true
! !

!FileReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__FileReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:03 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#BlockClosureReadStream
	instanceVariableNames:'contentsSpecies closeBlock'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals'
!

BlockClosureReadStream comment:'Read stream on a zero argument block, evaluates the block once for each requested element, the result of the block evaluation is the element.
{{{
	"inifinite stream of ones"
	[ 1 ] reading read: 20
}}}
{{{
	"Fibonacci"
	| a b | a := 0. b := 1.
	[ | x | x := a. a := b. b := x + a. x ] reading ++ 500; get
}}}
{{{
	"Streaming over ObjectMemory"
	x := ObjectMemory someObject.
	[ x := ObjectMemory nextObjectAfter: x ] reading read: 5
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream
	closeBlock	<BlockClosure> invoked in response to the #close message, allows customizing the close behavior

'
!


!BlockClosureReadStream methodsFor:'accessing'!

get
	^source value
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger] whileTrue:
		[aSequenceableCollection at: startIndex + count put: source value.
		count := count + 1]]
			on: Incomplete do: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!BlockClosureReadStream methodsFor:'initialize-release'!

close
	closeBlock cull: self
!

closeBlock
	^closeBlock
!

closeBlock: aBlock
	closeBlock := aBlock
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: anObject
	contentsSpecies := anObject
!

on: aBlockClosure
	super on: aBlockClosure.
	contentsSpecies := Array.
	closeBlock := []
! !

!BlockClosureReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BlockClosureReadStream.st 10 2011-08-22 16:04:00Z mk $'
! !
!WriteStream methodsFor:'transforming'!

buffering: bufferSize
	"Delays committing its content to its underlying stream until it has reached a certain size ,#flush is sent, or the stream is closed."
	"       bufferSize      <Integer> The size of the buffer to start with.
		^<PositionWriteStream>"
	"
		(ByteArray new writing buffering: 5)
			write: (ByteArray withAll: (1 to: 11));
			conclusion
	"
	^BufferedWriteStream on: self bufferSize: bufferSize
! !

!UndefinedObject methodsFor:'converting'!

writing
        ^Xtreams::NullWriteStream new
! !

!Block methodsFor:'converting'!

reading
        self numArgs = 0 ifTrue: [^Xtreams::BlockClosureReadStream on: self].
        self numArgs = 1 ifTrue: [^Xtreams::BlockClosureGenerateStream on: self].
        self error: 'More arguments than we can poke a stick at!!'
! !

!Block methodsFor:'converting'!

writing
        self numArgs = 1 ifTrue: [^Xtreams::BlockClosureWriteStream on: self].
        self error: 'Must be a single argument block.'
! !

!Socket methodsFor:'converting'!

accepting
	"Return a read stream that produces new sockets from incoming connections."

	"^	ReadStream"

	"Listen for connections and close those connections immediately.
	| socket |
	socket := SocketAccessor newTCP.
	socket listenFor: 1.
	[socket acceping do: [:client | client close]]
		ensure: [socket close]
	"

	^[self accept] reading
		closeBlock: [self close];
		yourself
! !

!Socket methodsFor:'converting'!

reading
	^ExternalReadStream on: self
! !

!Socket methodsFor:'converting'!

writing
	^ExternalWriteStream on: self
! !

!Buffer methodsFor:'converting'!

reading
	^BufferReadStream on: self
! !

!Buffer methodsFor:'converting'!

writing
	^BufferWriteStream on: self
! !

!SharedQueue methodsFor:'converting'!

reading
        ^Xtreams::SharedQueueReadStream on: self
! !

!SharedQueue methodsFor:'converting'!

writing
        ^Xtreams::SharedQueueWriteStream on: self
! !

!TextCollector methodsFor:'converting'!

writing
	^[:object | self nextPut: object] writing
! !

!SequenceableCollection methodsFor:'converting'!

reading
        ^Xtreams::SequenceableCollectionReadStream on: self
! !

!SequenceableCollection methodsFor:'converting'!

writing
        ^Xtreams::SequenceableCollectionWriteStream on: self
! !

!Filename methodsFor:'converting'!

appending
	^(IOAccessor openFileNamed: self direction: IOAccessor appendOnly creation: IOAccessor mayCreate) writing
		position: self fileSize;
		isPositionable: false;
		yourself
! !

!Filename methodsFor:'converting'!

reading
	self isDirectory ifFalse: [^(IOAccessor openFileNamed: self direction: IOAccessor readOnly creation: IOAccessor noCreate) reading].

	"Return the directory contents as a stream of filenames"
	^([self directoryContents]
		on:	self errorReporter errorSignal
		do:	[:ex | ex return: #()])
			reading collecting: [:each | self construct: each asFilename]
! !

!Filename methodsFor:'converting'!

writing
	^(IOAccessor openFileNamed: self direction: IOAccessor writeOnly creation: IOAccessor mayCreate) writing
! !

!Collection methodsFor:'converting'!

writing
        ^Xtreams::CollectionWriteStream on: self
! !

!Random methodsFor:'converting'!

reading
	^[self next] reading
		contentsSpecies: self contentsSpecies;
		yourself
! !

