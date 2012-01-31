'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#ReadSubstream
	instanceVariableNames:'sourceAtEnd closeBlock substreamClosed'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

ReadSubstream comment:'This is abstract superclass of all substreams. Substreams normally don''t close their underlying source, their closing behavior is customized via closeBlock.

Instance Variables
	sourceAtEnd	<Boolean> flags end of the source
	closeBlock	<BlockClosure> unary block invoked in response to #close, allows customizing closing behavior
	substreamClosed	<Boolean> flags the end of the receiver

'
!


!ReadSubstream class methodsFor:'private'!

slice: sliceBlock close: closeBlock
	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream sourceAtEnd ifTrue: [Incomplete zero raise]].
	substream := sliceBlock value]
		reading
			closeBlock: closeBlock;
			yourself
! !

!ReadSubstream methodsFor:'accessing'!

closeBlock
	^closeBlock
!

closeBlock: anObject
	closeBlock := anObject
!

get
	^[source get] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]
!

read: anInteger into: aSequenceableCollection at: startIndex
	^[source read: anInteger into: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]
! !

!ReadSubstream methodsFor:'initialize-release'!

close
	closeBlock cull: self.
	substreamClosed := true
!

contentsSpecies
	^source contentsSpecies
!

on: aSource
	super on: aSource.
	closeBlock := [].
	sourceAtEnd := false.
	substreamClosed := false
!

subseekend
! !

!ReadSubstream methodsFor:'testing'!

sourceAtEnd
	^sourceAtEnd
!

substreamClosed
	^substreamClosed
! !

!ReadSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ReadSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

ReadSubstream subclass:#PositionReadSubstream
	instanceVariableNames:'position'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

PositionReadSubstream comment:'This is an abstract substreams that keeps track of its own position and allows positioning if the underlying stream is positionable.

Instance Variables
	position	<Integer> current position within the substream

'
!


!PositionReadSubstream methodsFor:'accessing'!

get
	| object |
	object := super get.
	position := position + 1.
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex
	[source read: anInteger into: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		sourceAtEnd := true.
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger
! !

!PositionReadSubstream methodsFor:'initialize-release'!

on: aSource
	super on: aSource.
	position := 0
! !

!PositionReadSubstream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	count := [source ++ count. count] on: Incomplete do: [ :ex | ex count ].
	position := position + count.
	count < anInteger ifTrue: [sourceAtEnd := true. (Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := anInteger min: position.
	count := [source -- count. count] on: Incomplete do: [ :ex | ex count ].
	position := position - count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	anInteger isZero ifFalse: [sourceAtEnd := false].
	^anInteger
!

-= anInteger
	position := self length - anInteger max: 0.
	^source -= anInteger
!

length
	^source available + position
!

position
	^position
!

position: anInteger
	| delta available |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].

	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: self length.
	delta := available - position.
	[delta positive
		ifTrue:	[source ++ delta]
		ifFalse:	[source -- delta negated]]
			on: Incomplete do: [sourceAtEnd := true].
	position := available.
	available = anInteger ifTrue: [^anInteger].
	(Incomplete count: available) raise
! !

!PositionReadSubstream methodsFor:'testing'!

isPositionable
	^source isPositionable
! !

!PositionReadSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionReadSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#WriteSubstream
	instanceVariableNames:'destinationAtEnd closeBlock substreamClosed'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

WriteSubstream comment:'This is abstract superclass of all substreams. Substreams normally don''t close their underlying source, their closing behavior is customized via closeBlock.

Instance Variables
	destinationAtEnd	<Boolean> flags end of the destination
	closeBlock	<BlockClosure> unary block invoked in response to #close, allows customizing closing behavior
	substreamClosed	<Boolean> flags the end of the receiver

'
!


!WriteSubstream class methodsFor:'private'!

slice: sliceBlock close: closeBlock
	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream destinationAtEnd ifTrue: [Incomplete zero raise]].
	substream := sliceBlock value]
		reading
			closeBlock: closeBlock;
			yourself
! !

!WriteSubstream methodsFor:'accessing'!

closeBlock
	^closeBlock
!

closeBlock: anObject
	closeBlock := anObject
!

insert: anInteger from: aSequenceableCollection at: startIndex
	[destination insert: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass].
	^anInteger
!

put: anObject
	[destination put: anObject] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass]
!

write: anInteger from: aSequenceableCollection at: startIndex
	[destination write: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass].
	^anInteger
! !

!WriteSubstream methodsFor:'initialize-release'!

close
	closeBlock cull: self.
	substreamClosed := true
!

contentsSpecies
	^destination contentsSpecies
!

on: aDestination
	super on: aDestination.
	closeBlock := [].
	destinationAtEnd := false.
	substreamClosed := false
!

subseekend
! !

!WriteSubstream methodsFor:'testing'!

destinationAtEnd
	^destinationAtEnd
!

substreamClosed
	^substreamClosed
! !

!WriteSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__WriteSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

LibraryDefinition subclass:#stx_goodies_xtreams_substreams
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

stx_goodies_xtreams_substreams comment:'Substreams are streams embedded in other streams. Often there are multiple substreams embedded sequentially in a parent stream (for example multipart MIME messages). This package allows efficient handling of common types of substreams.

        === Fixed size substreams (#limiting:) ===

Limiting substream starts at the position when the substream is created and ends when the specified number of elements is read or written.
{{{
        (''abcdefghijklmno'' reading limiting: 10) rest
}}}
{{{
        | stream substream |
        stream := String new writing.
        substream := stream limiting: 5.
        [ substream write: ''Hello World!!'' ] on: Incomplete do: [].
        stream conclusion
}}}


        === Bounded substreams (#ending:/#ending:inclusive:) ===

Bounded substream ends when the argument matches the content passing through the stream. The argument can take one of the following forms:
  * a block - evaluated with each element; the stream ends when the block returns true
{{{
        (''abcdefghijklmnopqrstuvxyz'' reading ending: [ :e | ''gmt'' includes: e ]) rest.
}}}
{{{
        | stream substream |
        stream := String new writing.
        substream := stream ending: [ :e | ''gmt'' includes: e ].
        [ substream write: ''abcdefghijklmnopqrstuvxyz'' ] on: Incomplete do: [].
        stream conclusion
}}}
  * a collection - matched against the matching amount of last elements going through the stream; the stream ends when the collection matches
{{{
        (''abcdefghijklmnopqrstuvxyz'' reading ending: ''mno'' inclusive: true) rest.
}}}
{{{
        | stream substream |
        stream := String new writing.
        substream := stream ending: ''mno''.
        [ substream write: ''abcdefghijklmnopqrstuvxyz'' ] on: Incomplete do: [].
        stream conclusion
}}}
  * any other object - the stream ends when an equal element passes through the stream"
{{{
        (''ab#cd#ef!!ABC##'' reading ending: $!!) rest.
}}}
{{{
        | stream substream |
        stream := String new writing.
        substream := stream ending: $!!.
        [ substream write: ''Hello World!! Bye World!!'' ] on: Incomplete do: [].
        stream conclusion
}}}
There is also a longer form #ending:inclusive: which takes an additional Boolean argument determining if the matching elements should be part of the substream content or not. The short form assumes the matching elements should be omitted.
{{{
        (''abcdefghijklmnopqrstuvxyz'' reading ending: [ :e | ''gmt'' includes: e ] inclusive: true) rest.
}}}
{{{
        | stream substream |
        stream := String new writing.
        substream := stream ending: [ :e | ''gmt'' includes: e ] inclusive: true.
        [ substream write: ''abcdefghijklmnopqrstuvxyz'' ] on: Incomplete do: [].
        stream conclusion
}}}
Finally, closing a substream doesn''t close the underlying stream by default. This is usually desirable because another substream is likely to follow so the main stream cannot be closed in that case. So in normal use the main stream is usually closed separately from the substreams. However, closing behavior of any substream can be modified through a custom closeBlock: if different behavior is desired.
{{{
        | limited |
        limited := (String new writing limiting: 10) closeBlock: [ :stream | stream destination close ]; yourself.
        [ limited write: Object comment ] on: Incomplete do: [ :ex | ].
        limited close; terminal
}}}


        === Streams of substreams (slicing and stitching) ===

Slicing and Stitching is a meta-stream concept. Slicing breaks a stream with content that is delimited in some fashion (limiting:, ending:, etc) in to multiple substreams. The result of slicing is a read stream of substreams. Stitching is the inverse of slicing. It takes a read stream of streams and stiches those back together to look like a single continuous stream. Stitching a slicing stream will normally give the same result as the original underlying stream.

Here is an example that creates a slicing stream that cuts the input up into substreams of size 5.
{{{
        ((1 to: 49) reading limiting: 5) slicing collect: [ :slice | slice rest ]
}}}
Note that only the latest substream is active, previous substream is automatically depleted before next substream is created.
Also note that since slicing always creates substreams, it is always a read stream, even if you''re slicing a write stream. Output of the slicing stream are the substreams. Again, only the latest substream is active. The previous substream is automatically closed before next substream is created.
{{{
        | samples slices |
        samples := String new writing.
        slices := (samples limiting: 3) slicing.
        Date.MonthNames do: [ :month | [ slices get write: month ] on: Xtreams.Incomplete do: [] ].
        samples conclusion
}}}

In the following example the stream contains multiple messages delimited by $!! and each message has multiple parts ending with $#. We want to process each part as a stream of its own (this is a simplified version of how multipart messages are represented in MIME).
{{{
        | messages |
        messages := (''ab#cd#ef!!ABC##'' reading ending: $!!) slicing.
        messages collect: [ :message |
                (message ending: $#) slicing collect: [ :part | part rest ] ]
}}}
Note that since only the last slice is active any sort of read-ahead will likely interfere with the expected behavior, e.g. if we used collecting: instead of collect: in the example above, it would not work.

To generate the "hash-bang" style message encoding used in previous example we don''t need any sort of end-detecting substream. Instead we need to emit the closing character when the substream is closed. There is a special "closing" substream and corresponding slicer for that as well.
{{{
        | connection messages |
        connection := String new writing.
        messages := (connection closing: [ connection put: $!! ]) slicing.
        3 timesRepeat: [ | parts message |
                message := messages get.
                parts := (message closing: [ connection put: $# ]) slicing.
                #(one two three four) do: [ :body | parts get write: body ] ].
        connection conclusion
}}}
Stitching takes a read stream of streams and makes them behave as a single continuous stream. Following example takes the ''chunks'' and stitches them together.
{{{
        | chunks |
        chunks := (#(''abc'' ''de'' '''' ''fghij'') collect: [ :c | c reading ]) reading.
        chunks stitching rest
}}}
The stream of streams can be inifinite in which case the stitching stream is inifinite as well. For example the following stitching stream will not end.
{{{
        | main |
        main := (1 to: 10) reading.
        [ main limiting: 3 ] reading stitching rest
}}}
The problem is that the underlying stream of streams keeps producing empty limiting streams at the end of the main stream. To make the example end with an empty limiting stream can be done as follows.
{{{
        | main wasEmpty |
        main := (1 to: 10) reading.
        wasEmpty := false.
        [       wasEmpty ifTrue: [ Incomplete zero raise ].
                wasEmpty := true.
                (main doing: [ :e | wasEmpty := false ]) limiting: 3
        ] reading stitching rest
}}}
Here the #doing: transform captures the fact that there was in fact an element flowing through the limited: stream and sets the wasEmpty flag accordingly. This way we can detect the first empty limiting: stream and raise Incomplete. Alternatively the block stream can capture the substream in a variable and before creating next one it can check if its position reached the limit.
{{{
        | main current |
        main := (1 to: 10) reading.
        current := nil.
        [       (current notNil and: [ current position < 3 ]) ifTrue: [ Incomplete zero raise ].
                current := main limiting: 3
        ] reading stitching rest
}}}
Following example traverses current directory recursively by continuously adding to a queue of directories to search from and using the stitching to combine them together in to one long stream of filenames.
{{{
        | directories files |
        directories := Xtreams.ElasticBuffer new: 10 class: Array.
        directories put: ''.'' asFilename.
        files :=
                [       directories get reading
                                doing: [:filename | filename isDirectory ifTrue: [directories put: filename]]
                ] reading stitching.
        files rest
}}}

A practical example of stitching write streams is chunking of written content into size-prefixed chunks of some maximum size. This is something that can be often seen in network protocols (e.g. when individual chunks need to be encrypted or signed).
{{{
        | output buffer |
        output := ByteArray new writing.
        buffer := RingBuffer on: (ByteArray new: 5).
        [       (buffer writing limiting: buffer cacheSize)
                        closeBlock: [ output put: buffer readSize; write: buffer ];
                        yourself
        ] reading stitching
                write: (1 to: 22); close.
        output close terminal
}}}
'
!

!stx_goodies_xtreams_substreams class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 76 2012-01-30 22:41:10Z mkobetic $'
! !

!stx_goodies_xtreams_substreams class methodsFor:'description'!

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
        #'stx:goodies/xtreams/core'    "Xtreams::WriteStream - superclass of Xtreams::TestWriteSubstream "
        #'stx:goodies/xtreams/support'
        #'stx:libbasic'    "Object - superclass of Xtreams::TestWriteSubstream "
    )
! !

!stx_goodies_xtreams_substreams class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'Xtreams::ReadSubstream'
        #'Xtreams::StitchReadStream'
        #'Xtreams::StitchWriteStream'
        #'Xtreams::WriteSubstream'
        #'stx_goodies_xtreams_substreams'
        #'Xtreams::MatchReadSubstream'
        #'Xtreams::MatchWriteSubstream'
        #'Xtreams::PositionReadSubstream'
        #'Xtreams::PositionWriteSubstream'
        #'Xtreams::TestReadSubstream'
        #'Xtreams::TestWriteSubstream'
        #'Xtreams::LimitReadSubstream'
        #'Xtreams::LimitWriteSubstream'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        Block streamingReadMatching:inclusive:
        Block streamingWriteMatching:inclusive:
        Object streamingReadMatching:inclusive:
        Object streamingWriteMatching:inclusive:
        SequenceableCollection streamingMatchPrefixFunction
        SequenceableCollection streamingReadMatching:inclusive:
        SequenceableCollection streamingWriteMatching:inclusive:
        #'Xtreams::ReadStream' #','
        #'Xtreams::ReadStream' closing:
        #'Xtreams::ReadStream' ending:
        #'Xtreams::ReadStream' ending:inclusive:
        #'Xtreams::ReadStream' limiting:
        #'Xtreams::ReadStream' slicing
        #'Xtreams::ReadStream' stitching
        #'Xtreams::WriteStream' closing:
        #'Xtreams::WriteStream' ending:
        #'Xtreams::WriteStream' ending:inclusive:
        #'Xtreams::WriteStream' limiting:
        #'Xtreams::WriteStream' slicing
        #'Xtreams::WriteStream' stitching
        Block cull:
        Block cull:cull:
        SequenceableCollection copyGrownToAtLeast:
        SequenceableCollection recycle
    )
! !

!stx_goodies_xtreams_substreams class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_substreams class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/substreams/stx_goodies_xtreams_substreams.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'77'"$"
! !

!stx_goodies_xtreams_substreams class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_substreams.st 14 2011-11-21 06:01:55Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#StitchWriteStream
	instanceVariableNames:'active contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

StitchWriteStream comment:'StitchWriteStream combines a stream of source which returns streams in to a single continuous stream.

Instance Variables
	active	<WriteStream>	the substream that is currently active
	contentsSpecies	<Class>	the contents species of the substreams

'
!


!StitchWriteStream class methodsFor:'instance creation'!

on: aDestination contentsSpecies: aClass
	^self new on: aDestination contentsSpecies: aClass
!

on: aDestination first: firstActiveStream
	^self new on: aDestination first: firstActiveStream
! !

!StitchWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex
	| remaining amount index |
	index := startIndex.
	remaining := anInteger.
	amount := 0.
	[
		active == nil ifTrue: [
			[active := destination get]
				on: Incomplete
				do: [ :ex | (Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].
		amount := [active write: remaining from: aSequenceableCollection at: index] on: Incomplete do: [:ex | ex count].
		remaining := remaining - amount.
		index := index + amount.
		remaining > 0] whileTrue:
			[active close.
			active := nil].
	^anInteger
! !

!StitchWriteStream methodsFor:'initialize-release'!

close
	self flush.
	destination close
!

contentsSpecies
	^contentsSpecies
!

flush
	active == nil ifTrue: [^self].
	active close.
	active := nil
!

on: aDestination contentsSpecies: aClass
	super on: aDestination.
	contentsSpecies := aClass
!

on: aDestination first: firstActiveStream
	super on: aDestination.
	active := firstActiveStream.
	contentsSpecies := active contentsSpecies
! !

!StitchWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__StitchWriteStream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

WriteSubstream subclass:#PositionWriteSubstream
	instanceVariableNames:'position'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

PositionWriteSubstream comment:'This is an abstract substreams that keeps track of its own position and allows positioning if the underlying stream is positionable.

Instance Variables
	position	<Integer> current position within the substream

'
!


!PositionWriteSubstream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	[destination insert: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger
!

put: anObject
	| object |
	object := destination put: anObject.
	position := position + 1.
	^object
!

write: anInteger from: aSequenceableCollection at: startIndex
	[destination write: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger
! !

!PositionWriteSubstream methodsFor:'initialize-release'!

on: aDestination
	super on: aDestination.
	position := 0
! !

!PositionWriteSubstream methodsFor:'seeking'!

++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	count := [destination ++ count. count] on: Incomplete do: [ :ex | ex count ].
	position := position + count.
	count < anInteger ifTrue: [destinationAtEnd := true. (Incomplete count: count) raise].
	^anInteger
!

-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := anInteger min: position.
	count := [destination -- count. count] on: Incomplete do: [ :ex | ex count ].
	position := position - count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	anInteger isZero ifFalse: [destinationAtEnd := false].
	^anInteger
!

-= anInteger
	position := self length - anInteger max: 0.
	^destination -= anInteger.
!

length
	^destination available + position
!

position
	^position
!

position: anInteger
	| available adjustment |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].

	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: self length.
	adjustment := available - position.
	adjustment positive
		ifTrue: [ destination ++ adjustment ]
		ifFalse: [ destination -- adjustment negated ].
	position := available.
	available = anInteger ifTrue: [^anInteger].
	(Incomplete count: available) raise
! !

!PositionWriteSubstream methodsFor:'testing'!

isPositionable
	^destination isPositionable
! !

!PositionWriteSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionWriteSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

PositionReadSubstream subclass:#LimitReadSubstream
	instanceVariableNames:'limit'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

LimitReadSubstream comment:'Limits the number of elements that can be read from the source stream.

Instance Variables
	limit	<Integer> maximum number of elements that can be read from this stream
	position	<Integer> number of elements already read from the stream

'
!


!LimitReadSubstream class methodsFor:'instance creation'!

on: aSource limit: anInteger
	^self new on: aSource limit: anInteger
! !

!LimitReadSubstream methodsFor:'accessing'!

get
	position = limit ifTrue: [Incomplete zero raise].
	^super get
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super read: count into: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!LimitReadSubstream methodsFor:'initialize-release'!

on: aSource limit: anInteger
	self on: aSource.
	limit := anInteger
!

subseekend
	self isPositionable ifFalse: [^self].
	self -= 0
! !

!LimitReadSubstream methodsFor:'seeking'!

-= anInteger
	| available |
	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: limit.
	source ++ (limit - position - available).
	position := limit - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise
!

length
	^limit
! !

!LimitReadSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__LimitReadSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

WriteSubstream subclass:#TestWriteSubstream
	instanceVariableNames:'substreamAtEnd test inclusive'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

TestWriteSubstream comment:'This is a substream bounded by an element matching the @test criteria.

Instance Variables
	substreamAtEnd	<Boolean> is this substream at end
	test	<BlockClosure> the bounding criteria
	inclusive	<Boolean> is the boundary part of the substream contents

'
!


!TestWriteSubstream class methodsFor:'instance creation'!

on: aDestination test: testBlock inclusive: aBoolean
	^self new on: aDestination test: testBlock inclusive: aBoolean
! !

!TestWriteSubstream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	^self write: anInteger from: aSequenceableCollection at: startIndex
!

put: anObject
	substreamAtEnd ifTrue: [Incomplete zero raise].
	((substreamAtEnd := test value: anObject) and: [inclusive not]) ifTrue: [Incomplete zero raise].
	[destination put: anObject] on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. incomplete pass].
	^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count object |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[object := aSequenceableCollection at: startIndex + count.
		((substreamAtEnd := test value: object) and: [inclusive not]) ifFalse: [destination put: object].
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!TestWriteSubstream methodsFor:'initialize-release'!

on: aDestination test: testBlock inclusive: aBoolean
	self on: aDestination.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false
! !

!TestWriteSubstream methodsFor:'private'!

streamingInsert: anInteger from: aReadStream
	self streamingWrite: anInteger from: aReadStream
!

streamingInsertFrom: aReadStream
	self streamingWriteFrom: aReadStream
!

streamingWrite: anInteger from: aReadStream
	| count object |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[object := aReadStream get.
		((substreamAtEnd := test value: object) and: [inclusive not]) ifFalse: [destination put: object].
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete count: count) raise].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

streamingWriteFrom: aReadStream
	| object count |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	^[[substreamAtEnd not] whileTrue:
		[object := aReadStream get.
		((substreamAtEnd := test value: object) and: [inclusive not]) ifFalse: [destination put: object. count := count + 1]].
		count
	] on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. count ]
! !

!TestWriteSubstream methodsFor:'testing'!

isPositionable
	^false
! !

!TestWriteSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__TestWriteSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

WriteSubstream subclass:#MatchWriteSubstream
	instanceVariableNames:'substreamAtEnd pattern patternStart inclusive backtrack'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

MatchWriteSubstream comment:'This is a substream bounded by a string pattern. The algorithm used doesn''t need to peek or step back to detect the pattern, so it can be used on non-positionable streams.

Instance Variables
	substreamAtEnd	<Boolean> is this substream at end
	pattern	<String> the bounding pattern
	patternStart	<Integer> 
	inclusive	<Boolean> is the boundary part of the substream contents
	backtrack	<Array> backtracking table for pattern

'
!


!MatchWriteSubstream class methodsFor:'instance creation'!

on: aDestination pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	^self new on: aDestination pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
! !

!MatchWriteSubstream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	^self write: anInteger from: aSequenceableCollection at: startIndex
!

put: anObject
	substreamAtEnd ifTrue: [Incomplete zero raise].
	[self gobble: anObject] on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. incomplete pass].
	^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[self gobble: (aSequenceableCollection at: startIndex + count).
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue:
		[substreamAtEnd := true.
		(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!MatchWriteSubstream methodsFor:'initialize-release'!

on: aDestination pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aDestination.
	pattern := aPattern.
	backtrack := aBacktrack.
	patternStart := 1.
	inclusive := aBoolean.
	substreamAtEnd := false
! !

!MatchWriteSubstream methodsFor:'private'!

gobble: anObject
	| patternStop match |
	patternStop := patternStart.
	(match := anObject = (pattern at: patternStop)) ifTrue: [patternStop := patternStop + 1].

	"A full pattern match"
	patternStop > pattern size ifTrue: [
		inclusive ifTrue: [destination write: pattern size from: pattern at: 1].
		substreamAtEnd := true.
		^self].

	"Partial match, in progress"
	match ifTrue: [patternStart := patternStop. ^self].

	"No match at all, write out the object we just read"
	patternStart = 1 ifTrue: [
		destination put: anObject.
		patternStart := 1.
		^self].

	"Partial match was in progress, but anObject didn't match, so write out the part of the pattern and try anObject again from the backtrack position"
	destination write: patternStart - 1 from: pattern at: 1.
	patternStart := backtrack at: patternStop.
	self gobble: anObject
!

streamingInsert: anInteger from: aReadStream
	self streamingWrite: anInteger from: aReadStream
!

streamingInsertFrom: aReadStream
	self streamingWriteFrom: aReadStream
!

streamingWrite: anInteger from: aReadStream
	| count |
	count := 0.
	[[count < anInteger and: [substreamAtEnd not]] whileTrue:
		[self gobble: aReadStream get.
		count := count + 1]]
			on: Incomplete do: [:incomplete |
				destinationAtEnd := substreamAtEnd := true.
				(Incomplete count: count) raise].
	count < anInteger ifTrue:
		[substreamAtEnd := true.
		(Incomplete count: count) raise].
	^anInteger
!

streamingWriteFrom: aReadStream
	| count |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	^[[substreamAtEnd not] whileTrue: [self gobble: aReadStream get. count := count + 1]]
		on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. count ]
! !

!MatchWriteSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__MatchWriteSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

ReadSubstream subclass:#MatchReadSubstream
	instanceVariableNames:'substreamAtEnd pattern patternStart inclusive hasReread reread
		buffer backtrack'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

MatchReadSubstream comment:'This is a substream bounded by a string pattern. The algorithm used doesn''t need to peek or step back to detect the pattern, so it can be used on non-positionable streams.

Instance Variables
	substreamAtEnd	<Boolean> is this substream at end
	pattern	<String> the bounding pattern
	patternStart	<Integer>
	inclusive	<Boolean> is the boundary part of the substream contents
	hasReread	<Boolean>
	reread	<Object>
	buffer	<RingBuffer> read-ahead buffer (to be able to stop before pattern if inclusive is false)
	backtrack	<Array> backtracking table for pattern

'
!


!MatchReadSubstream class methodsFor:'instance creation'!

on: aSource pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	^self new on: aSource pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
! !

!MatchReadSubstream methodsFor:'accessing'!

get
	buffer hasDataToRead ifTrue: [^buffer get].
	substreamAtEnd ifTrue: [Incomplete zero raise].

	self gobble.
	buffer hasDataToRead ifFalse: [Incomplete zero raise].
	^buffer get
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		amount := buffer readSize min: (anInteger - count).
		buffer read: amount into: aSequenceableCollection at: startIndex + count.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!MatchReadSubstream methodsFor:'initialize-release'!

close
	super close.
	buffer recycle
!

on: aSource pattern: aPattern backtrack: aBacktrack inclusive: aBoolean
	self on: aSource.
	pattern := aPattern.
	buffer := RingBuffer new: pattern size class: self contentsSpecies.
	hasReread := false.
	backtrack := aBacktrack.
	patternStart := 1.
	inclusive := aBoolean.
	substreamAtEnd := false
!

subseekend
	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer readSkip: buffer readSize]
! !

!MatchReadSubstream methodsFor:'private'!

gobble
	| object match patternStop progress |
	patternStop := patternStart.
	[hasReread
		ifTrue: [hasReread := false. object := reread. reread := nil]
		ifFalse: [object := source get].
	[(match := object = (pattern at: patternStop)) ifTrue: [patternStop := patternStop + 1].
	match and: [patternStop <= pattern size]]
		whileTrue: [object := source get]]
			on: Incomplete do: [:incomplete |
				sourceAtEnd := substreamAtEnd := true].

	"A full pattern match"
	patternStop > pattern size ifTrue: [
		inclusive ifTrue: [buffer write: pattern size from: pattern at: 1].
		substreamAtEnd := true.
		^self].

	"No match at all, write out the object we just read"
	progress := patternStop - patternStart.
	(patternStart = 1 and: [progress = 0]) ifTrue: [
		sourceAtEnd ifFalse: [buffer put: object].
		patternStart := 1.
		^self].

	"Partial match, write out the part of the pattern previously matched and keep the object we just read to be re-read next time"
	hasReread := true.
	reread := object.
	buffer write: progress from: pattern at: patternStart.
	patternStart := backtrack at: patternStop
!

streamingInsert: anInteger into: aWriteStream
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete count: count) raise].
		amount := buffer readSize min: (anInteger - count).
		aWriteStream insert: amount from: buffer.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete count: count) raise]
!

streamingInsertInto: aWriteStream
	| amount |

	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream insert: amount from: buffer]
!

streamingWrite: anInteger into: aWriteStream
	| count amount |

	count := 0.
	[count < anInteger and: [buffer hasDataToRead or: [substreamAtEnd not]]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer hasDataToRead ifFalse: [(Incomplete count: count) raise].
		amount := buffer readSize min: (anInteger - count).
		aWriteStream write: amount from: buffer.
		count := count + amount].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

streamingWriteInto: aWriteStream
	| amount count |
	count := 0.
	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream write: amount from: buffer.
		count := count + amount ].
	^count
! !

!MatchReadSubstream methodsFor:'seeking'!

-= anInteger
	^anInteger isZero
		ifTrue:	[self subseekend. 0]
		ifFalse:	[super -= anInteger]
! !

!MatchReadSubstream methodsFor:'testing'!

isPositionable
	^false
! !

!MatchReadSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__MatchReadSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

ReadSubstream subclass:#TestReadSubstream
	instanceVariableNames:'substreamAtEnd test inclusive'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

TestReadSubstream comment:'This is a substream bounded by an element matching the @test criteria.

Instance Variables
	substreamAtEnd	<Boolean> is this substream at end
	test	<BlockClosure> the bounding criteria
	inclusive	<Boolean> is the boundary part of the substream contents

'
!


!TestReadSubstream class methodsFor:'instance creation'!

on: aSource test: testBlock inclusive: aBoolean
	^self new on: aSource test: testBlock inclusive: aBoolean
! !

!TestReadSubstream methodsFor:'accessing'!

get
	| object |
	substreamAtEnd ifTrue: [Incomplete zero raise].
	object := [source get] on: Incomplete do: [:incomplete | sourceAtEnd := substreamAtEnd := true. incomplete pass].
	(substreamAtEnd := test value: object) ifTrue:
		[inclusive ifTrue: [^object].
		Incomplete zero raise].
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex
	| object count |

	substreamAtEnd ifTrue: [(Incomplete on: aSequenceableCollection count: 0 at: startIndex) raise].
	count := 0.
	[[count = anInteger or: [substreamAtEnd]] whileFalse:
		[object := source get.
		((substreamAtEnd := test value: object) not or: [inclusive]) ifTrue:
			[aSequenceableCollection at: startIndex + count put: object.
			count := count + 1]]]
				on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. (Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!TestReadSubstream methodsFor:'initialize-release'!

on: aSource test: testBlock inclusive: aBoolean
	self on: aSource.
	test := testBlock.
	inclusive := aBoolean.
	substreamAtEnd := false
!

subseekend
	| object |
	substreamAtEnd ifTrue: [^self].
	[[substreamAtEnd] whileFalse:
		[object := source get.
		substreamAtEnd := test value: object]]
			on: Incomplete do: [sourceAtEnd := substreamAtEnd := true]
! !

!TestReadSubstream methodsFor:'private'!

streamingWrite: anInteger into: aWriteStream
	| object count |

	substreamAtEnd ifTrue: [Incomplete zero raise].
	count := 0.
	[[count = anInteger or: [substreamAtEnd]] whileFalse:
		[object := source get.
		((substreamAtEnd := test value: object) not or: [inclusive]) ifTrue:
			[aWriteStream put: object.
			count := count + 1]]]
				on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. (Incomplete count: count) raise].
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
!

streamingWriteInto: aWriteStream
	| object count |
	substreamAtEnd ifTrue: [^0].
	count := 0.
	^[	[	substreamAtEnd
		] whileFalse: [
			object := source get.
			(substreamAtEnd := test value: object)
				ifTrue:	[inclusive ifTrue: [aWriteStream put: object. count := count + 1]]
				ifFalse:	[aWriteStream put: object. count := count + 1]].
		count
	] on: Incomplete do: [sourceAtEnd := substreamAtEnd := true. count ]
! !

!TestReadSubstream methodsFor:'seeking'!

-= anInteger
	^anInteger isZero
		ifTrue:	[self subseekend. 0]
		ifFalse:	[super -= anInteger]
! !

!TestReadSubstream methodsFor:'testing'!

isPositionable
	^false
! !

!TestReadSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__TestReadSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

PositionWriteSubstream subclass:#LimitWriteSubstream
	instanceVariableNames:'limit'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

LimitWriteSubstream comment:'Limits the number of elements that can be written into the destination stream.

Instance Variables
	limit	<Integer> maximum number of elements that can be written into this stream
	position	<Integer> number of elements already written into the stream

'
!


!LimitWriteSubstream class methodsFor:'instance creation'!

on: aDestination limit: anInteger
	^self new on: aDestination limit: anInteger
! !

!LimitWriteSubstream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super insert: count from: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
!

put: anObject
	position = limit ifTrue: [Incomplete zero raise].
	^super put: anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: self available.
	super write: count from: aSequenceableCollection at: startIndex.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!LimitWriteSubstream methodsFor:'initialize-release'!

on: aDestination limit: anInteger
	self on: aDestination.
	limit := anInteger
!

subseekend
	self isPositionable ifFalse: [^self].
	self -= 0
! !

!LimitWriteSubstream methodsFor:'seeking'!

-= anInteger
	| available |
	anInteger < 0 ifTrue: [Incomplete zero raise].
	available := anInteger min: limit.
	destination ++ (limit - position - available).
	position := limit - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise
!

length
	^limit
! !

!LimitWriteSubstream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__LimitWriteSubstream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:11 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#StitchReadStream
	instanceVariableNames:'active contentsSpecies'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams'
!

StitchReadStream comment:'StitchReadStream combines a stream of source which returns streams in to a single continuous stream.

Instance Variables
	active	<ReadStream>	the substream that is currently active
	contentsSpecies	<Class>	the contents species of the substreams

'
!


!StitchReadStream class methodsFor:'instance creation'!

on: aSource contentsSpecies: aClass
	^self new on: aSource contentsSpecies: aClass
!

on: aSource first: firstActiveStream
	^self new on: aSource first: firstActiveStream
! !

!StitchReadStream methodsFor:'accessing'!

read: anInteger into: aSequenceableCollection at: startIndex
	| remaining amount index |
	index := startIndex.
	remaining := anInteger.
	amount := 0.
	[
		active == nil ifTrue: [
			[active := source get]
				on: Incomplete
				do: [:ex | (Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].
		amount := [active read: remaining into: aSequenceableCollection at: index] on: Incomplete do: [:ex | ex count].
		remaining := remaining - amount.
		index := index + amount.
		remaining > 0] whileTrue:
			[active close.
			active := nil].
	^anInteger
! !

!StitchReadStream methodsFor:'initialize-release'!

close
	active == nil ifFalse: [active close].
	super close
!

contentsSpecies
	^contentsSpecies
!

on: aSource contentsSpecies: aClass
	super on: aSource.
	contentsSpecies := aClass
!

on: aSource first: firstActiveStream
	super on: aSource.
	active := firstActiveStream.
	contentsSpecies := active contentsSpecies
! !

!StitchReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__StitchReadStream.st 68 2012-01-30 22:17:59Z mkobetic $'
! !
!Block methodsFor:'xtreams'!

streamingReadMatching: aStream inclusive: tail
        ^Xtreams::TestReadSubstream on: aStream test: self inclusive: tail
! !

!Block methodsFor:'xtreams'!

streamingWriteMatching: aStream inclusive: tail
        ^Xtreams::TestWriteSubstream on: aStream test: self inclusive: tail
! !

!WriteStream methodsFor:'substreaming'!

closing: aBlock
	^(PositionWriteSubstream on: self)
		closeBlock: aBlock;
		yourself
! !

!WriteStream methodsFor:'substreaming'!

ending: aMatchable
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element - the stream ends when the block returns true
		* a collection that is matched against the last elements written - the stream ends when the collection matches
		* any other object - the stream ends when an equal object is written into the stream"
	"	aMatchable	<BlockClosure | Collection | Object> the substream ending criteria
		^<TransformWriteStream>
	""	
		| stream slice |
		stream := String new writing.
		slice := stream ending: $j.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: 'mno'.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: [ :e | 'gmt' includes: e ].
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	"
	^self ending: aMatchable inclusive: false
! !

!WriteStream methodsFor:'substreaming'!

ending: aMatchable inclusive: inclusive
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element - the stream ends when the block returns true
		* a collection that is matched against the last elements written - the stream ends when the collection matches
		* any other object - the stream ends when an equal object is written into the stream"
	"	aMatchable	<BlockClosure | Collection | Object> the substream ending criteria
		inclusive <Boolean> should the matched elements be included in the stream contents or not
		^<TransformWriteStream>
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: $j inclusive: true.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: 'mno' inclusive: true.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	""
		| stream slice |
		stream := String new writing.
		slice := stream ending: [ :e | 'gmt' includes: e ] inclusive: true.
		[ slice write: 'abcdefghijklmnopqrstuvxyz' ] on: Incomplete do: [].
		stream conclusion
	"
	^aMatchable streamingWriteMatching: self inclusive: inclusive
! !

!WriteStream methodsFor:'substreaming'!

limiting: limit
	"Create a substream that will allow at most @limit number of elements written into the destination."
	"	limit	<Integer>	maximum number of elements that can be written into destination
		^<LimitWriteStream>"
	"
		| stream slice |
		stream := String new writing.
		slice := stream limiting: 5.
		[ slice write: 'abcdefghi' ] on: Incomplete do: [].
		stream conclusion
	"

	^LimitWriteSubstream on: self limit: limit
! !

!WriteStream methodsFor:'substreaming'!

slicing
	"From a writable stream, return a readable stream that acts as a prototype factory for the writable stream."
	"	^<ReadStream>"
	"(destination limiting: 10) slicing"

	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream destinationAtEnd ifTrue: [Incomplete zero raise]].
		substream := self copy]
		reading
			closeBlock: [destination close];
			yourself
! !

!WriteStream methodsFor:'substreaming'!

stitching
	^self error: 'You can only stitch a read stream, however that read stream can return write streams and in so doing, you will create a stitching write stream.'
! !

!ReadStream methodsFor:'substreaming'!

, aReadStream
	"Return a read stream that combines self and @aReadStream into a single stream.
	""
		((1 to: 5) reading, (6 to: 10) reading) rest
	""
		| files |
		files := '/pub/vw7.8' asFilename reading.
		[ | fn | fn := files get. fn isDirectory ifTrue: [ files := fn reading, files ]. fn ] reading rest
	"
	^(Array with: self with: aReadStream) reading stitching
! !

!ReadStream methodsFor:'substreaming'!

closing: aBlock
	^(PositionReadSubstream on: self)
		closeBlock: aBlock;
		yourself
! !

!ReadStream methodsFor:'substreaming'!

ending: aMatchable
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element; the stream ends when the block returns true
		* a collection that is matched against the last elements read, the stream ends when the collection matches
		* any other object, the stream matches when an equal object is read from the stream"
	"	aMatchable	<BlockClosure | Collection | Object>
		^<TransformReadStream>
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: $j) rest.
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: 'mno') rest
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: [ :e | 'gmt' includes: e ]) rest
	"
	^self ending: aMatchable inclusive: false
! !

!ReadStream methodsFor:'substreaming'!

ending: aMatchable inclusive: inclusive
	"Creates a substream that will end when aMatchable finds a match in the content passing through. aMatchable is either
		* a block that is evaluated with each element - the stream ends when the block returns true
		* a collection that is matched against the last elements read - the stream ends when the collection matches
		* any other object - the stream matches when an equal object is read from the stream
	The inclusive parameter determins if the elements matching the end condition should be included in the substream contents or not."
	"	aMatchable	<BlockClosure | Collection | Object>	the substream ending criteria
		inclusive	<Boolean> should the content matching the end condition be included in the substream
		^<TransformReadStream>
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: $j inclusive: true) rest.
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: 'mno' inclusive: true) rest
	""
		('abcdefghijklmnopqrstuvxyz' reading ending: [ :e | 'gmt' includes: e ] inclusive: true) rest
	"
	^aMatchable streamingReadMatching: self inclusive: inclusive
! !

!ReadStream methodsFor:'substreaming'!

limiting: limit
	"Create a substream that will allow at most @limit number of elements to be read from the source."
	"	limit		<Integer>	maximum number of elements that can be read from the source
		^<LimitReadStream>"
	"
		('abcdefghi' reading limiting: 5) rest
	"
	^LimitReadSubstream on: self limit: limit
! !

!ReadStream methodsFor:'substreaming'!

slicing
	"From a readable stream, return a readable stream that acts as a prototype factory for the readable stream."
	"	^<ReadStream>"
	"
		((1 to: 100) reading limiting: 10) slicing do: [:substream | Transcript cr; print: substream rest]
	"
	| substream |
	substream := nil.
	^[substream == nil ifFalse:
		[substream substreamClosed ifFalse: [substream close].
		substream subseekend.
		substream sourceAtEnd ifTrue: [Incomplete zero raise]].
	substream := self copy]
		reading
			closeBlock: [source close];
			yourself
! !

!ReadStream methodsFor:'substreaming'!

stitching
	"From a stream that returns streams (either read or write streams), stitch them together sequencially such that they appear to be one contiguous stream."
	"^ <StitchReadStream>"
	"
		| data current |
		data := (1 to: 100) reading.
		current := nil.
		[	(current notNil and: [ current position < 10 ]) ifTrue: [ Incomplete zero raise ].
			current := data limiting: 10
		] reading stitching rest
	"
	| first |
	first := self get.
	first isReadable ifTrue: [^StitchReadStream on: self first: first].
	first isWritable ifTrue: [^StitchWriteStream on: self first: first].
	^self error: 'Cannot read or write to this stream, what is it?'
! !

!SequenceableCollection methodsFor:'xtreams'!

streamingMatchPrefixFunction
	"Compute the array that tells us how far we need to back up when a match fails. This is using the Knuth-Morris-Pratt matching algorithm"

	| backtrack partialMatch |
	backtrack := Array new: self size + 1. 
	backtrack at: 1 put: 1; at: 2 put: 1.
	partialMatch := 1.

	2 to: self size do: [:index |
		| current |
		current := self at: index.

		"If there's a mismatch, back up to the previous partial match and see if the match can continue from there. If not, repeat until we find a match or hit the beginning"
		[partialMatch > 1 and: [(self at: partialMatch) ~= current]]
			whileTrue: [partialMatch := backtrack at: partialMatch - 1].

		(self at: partialMatch) = current
			ifTrue: [partialMatch := partialMatch + 1].
		backtrack at: index put: partialMatch].

	^backtrack
! !

!SequenceableCollection methodsFor:'xtreams'!

streamingReadMatching: aStream inclusive: tail
        "Return a stream that produces substreams that separate by @pattern and include the pattern in the result if @tail is true.
         It uses the Knuth-Morris-Pratt algorithm, from Cormen et al.'s Algorithms, page 871. See also Gusfield's Alorithms on Strings, Trees and Sequences, page 23. This algorithm has the advantage in stream matching that it reads every character in the the text to be matched against exactly once, and never backtracks."

        | backtrack |
        backtrack := self streamingMatchPrefixFunction.
        ^Xtreams::MatchReadSubstream on: aStream pattern: self backtrack: backtrack inclusive: tail
! !

!SequenceableCollection methodsFor:'xtreams'!

streamingWriteMatching: aStream inclusive: tail
        "Return a stream that produces substreams that separate by @pattern and include the pattern in the result if @tail is true.
         It uses the Knuth-Morris-Pratt algorithm, from Cormen et al.'s Algorithms, page 871. See also Gusfield's Alorithms on Strings, Trees and Sequences, page 23. This algorithm has the advantage in stream matching that it reads every character in the the text to be matched against exactly once, and never backtracks."

        | backtrack |
        backtrack := self streamingMatchPrefixFunction.
        ^Xtreams::MatchWriteSubstream on: aStream pattern: self backtrack: backtrack inclusive: tail
! !

!Object methodsFor:'xtreams'!

streamingReadMatching: aStream inclusive: tail
	^[:each | each == self] streamingReadMatching: aStream inclusive: tail
! !

!Object methodsFor:'xtreams'!

streamingWriteMatching: aStream inclusive: tail
	^[:each | each == self] streamingWriteMatching: aStream inclusive: tail
! !

