'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

Object subclass:#ReadStream
	instanceVariableNames:'source'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core'
!

ReadStream comment:'Abstract superclass of all read streams, defines the API.

Read streams are created by sending #reading to a concrete resource (a.k.a terminal), such as a Collection, SocketAccessor, Filename, etc.

	''testing'' reading rest

Transform read streams are created through one of the messages in the ''transforming'' protocol sent to other read streams.

	(''testing'' reading collecting: #asUppercase) rest

Subclasses must implement the following messages:
	#read:into:at:
	#contentsSpecies

Instance Variables
	source  <Object> a read stream or "terminal" producing the elements

'
!


!ReadStream class methodsFor:'instance creation'!

on: aSource
	^self new on: aSource
! !

!ReadStream methodsFor:'accessing'!

get
	"Read an object from self.
	If there aren't any elements left in the stream, the Incomplete exception is raised."
	"       ^       <Object> an object read from this stream
	"
	| cache object |
	cache := self contentsSpecies newRecycled: 1.
	self read: 1 into: cache at: 1.
	object := cache first.
	cache recycle.
	^object
!

read: anInteger
	"Read anInteger's worth of elements from self and return them in a collection.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"       anInteger       <Integer>       the number of elements to read
		^<SequenceableCollection>       a new collection containing anIntegers worth of elements
	"
	| newCollection |
	newCollection := self contentsSpecies withSize: anInteger.
	self read: anInteger into: newCollection at: 1.
	^newCollection
!

read: anInteger into: aSequenceableCollection
	"Read anInteger's worth of elements into aSequenceableCollection starting from index 1.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"       anInteger       <Integer>       the number of elements to read
		aSequenceableCollection <SequenceableCollection>        the destination to read into
		^<Integer>      number of elements read
	"
	^self read: anInteger into: aSequenceableCollection at: 1
!

read: anInteger into: aSequenceableCollection at: startIndex
	"Read anInteger's worth of elements into aSequenceableCollection starting at startIndex.
	If full anInteger number of elements cannot be read from the source, the Incomplete exception is raised."
	"       anInteger       <Integer>       the number of elements to read
		aSequenceableCollection <SequenceableCollection>        the destination to read into
		startIndex      <Integer>       the index into aSequenceableCollection to start writing to
		^<Integer>      number of elements read
	"
	self subclassResponsibility
	"Subclasses must implement this message. All effort must be taken to read anInteger, blocking if necessary. "
!

rest
	"Read all remaining elements from self."
	"       ^               <SequenceableCollection>        a new collection of elements read from this stream
	"

	"Implementation note: Originally we sent #close then #destination, but sending #close will perform a #become:
		and our constructed write stream is going to go away as soon as we leave this method, so we're better off
		using #contents instead"

	^self contentsSpecies new writing
		write: self;
		contents
!

source
	"Return the source of this stream."

	^source
!

terminal
	"Return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(source isKindOf: ReadStream)
		ifTrue: [ source terminal ]
		ifFalse: [ source ]
! !

!ReadStream methodsFor:'converting'!

reading
	^[[self next]
		on: EndOfStreamNotification
		do: [:notification |
			notification originator == self
				ifTrue:	[Incomplete zero raise]
				ifFalse:	[notification pass]]] reading
		contentsSpecies: self contentsSpecies;
		yourself
! !

!ReadStream methodsFor:'enumerating'!

collect: aBlock
	"Evaluate aBlock with each of the values of the receiver as the argument. Collect the resulting values into a collection."
	"       aBlock  <BlockClosure>  #collect: style block transforming the elements being read
		^               <Collection>
	""
		(1 to: 10) reading collect: [ :e | e * e ]
	"
	| contents |
	contents := self contentsSpecies new writing.
	self do: [:each | contents put: (aBlock value: each)].
	^contents close; destination
!

detect: aBlock
	"Evaluate aBlock with each of the receiver's elements as the argument. Answer the first element for which aBlock evaluates to true."
	"       aBlock  <BlockClosure>  #detect: style block
		^               <Object>        first element for which aBlock evalutes to true
	"
	^self detect: aBlock ifNone: [NotFoundError raise]
!

detect: aBlock ifNone: exceptionBlock
	"Evaluate aBlock with each of the receiver's elements as the argument. Answer the first element for which aBlock evaluates to true.
	Evaluate exceptionBlock if no such element is found."
	"       aBlock                  <BlockClosure>  #detect: style block
		exceptionBlock  <BlockClosure>  evaluated if there wasn't any element for which aBlock returns true
		^                               <Object>        first element for which aBlock evalutes to true
	"
	self do: [:each | (aBlock value: each) ifTrue: [^each]].
	^exceptionBlock value
!

do: aBlock
        "Read from the stream and pass the read objects to the #do: block one by one until it reaches the end of stream."
        "       aBlock  <BlockClosure>  #do: style block evaluated with each element
        "
        [[aBlock value: self get] repeat] on: Incomplete do: []
!

do: elementBlock separatedBy: separatorBlock
	"Evaluate elementBlock for each element in the stream. Between each pair of elements, but not before the first or after the last, evaluate the separatorBlock."
	"       elementBlock    <BlockClosure> evaluated with each element
		separatorBlock  <BlockClosure> evaluated between elements
	"
	| first |
	first := true.
	self do:
		[:elmnt |
		first ifTrue: [first := false]
			ifFalse: [separatorBlock value].
		elementBlock value: elmnt]
!

fold: binaryBlock
	"Evaluate binaryBlock with the 1st and th 2nd element of the stream, followed by the result of the first evaluation and the 3rd element of the stream, so on until the stream comes to an end."
	"       binaryBlock     <BlockClosure> evaluated with each element
	"

	| current |
	current := self get.
	self do: [:next | current := binaryBlock value: current value: next].
	^current
!

groupedBy: aBlock
	"Return a dictionary whose keys are the result of evaluating aBlock for all elements in  the stream, and the value for each key is a collection of elements that evaluated to that key.
	""      aBlock  <BlockClosure>  #collect: style block evaluated with each element
		^               <Dictionary>            keys are results of aBlock for all elements, values are corresponding elements that evaluated to the key
	""
	     #(1 2 3 4 5) reading groupedBy: [:each | each odd]
	"
	| result |
	result := Dictionary new.
	self do:
		[:each | | key collection |
		key := aBlock value: each.
		collection := result at: key ifAbsentPut: [OrderedCollection new].
		collection add: each].
	self species ~~ OrderedCollection ifTrue:
		["Convert the result collections to be the right type.
		  Note that it should be safe to modify the dictionary
		  while iterating because we only replace values for existing keys"
		result keysAndValuesDo:
			[:key :value | result at: key put: (self contentsSpecies withAll: value)]].

	^result
!

inject: initialValue into: binaryBlock
	"Accumulate a running value associated with evaluation of binaryBlock with the each element and the result of evaluation for previous element.
	The initialValue serves as the previous result for evaluation of the first element."
	"       initialValue    <Object>        servers as the previous result for evaluation of the first element.
		binaryBlock     <BlockClosure>  evaluated with each element and result of evaluation of previous element
	""
		(1 to: 10) reading inject: 0 into: [:subTotal :next | subTotal + next].
	"
	| nextValue |
	nextValue := initialValue.
	self do: [:each | nextValue := binaryBlock value: nextValue value: each].
	^nextValue
!

reject: aBlock
	"Evaluate aBlock with each element, collect into a collection only those elements for which aBlock evaluates to false."
	"       aBlock  <BlockClosure>  #reject: style block used to filter the elements
		^               <Collection>            all elements that evaluate to false
	""
		(1 to: 10) reading reject: [ :e | e odd ]
	"
	^self select: [:element | (aBlock value: element) == false]
!

select: aBlock
	"Evaluate aBlock with each element, collect into a collection only those elements for which aBlock evaluates to true."
	"       aBlock  <BlockClosure>  #select: style block used to filter the elements
		^               <Collection>            all elements that evaluate to true
	""
		(1 to: 10) reading select: [ :e | e odd ]
	"
	| contents |
	contents := self contentsSpecies new writing.
	self do: [:each | (aBlock value: each) ifTrue: [contents put: each]].
	^contents close; destination
! !

!ReadStream methodsFor:'initialize-release'!

close
	source close
!

contentsSpecies
	"Returns collection class suitable to hold elements of this stream."
	^self subclassResponsibility
!

on: aSource
	source := aSource
! !

!ReadStream methodsFor:'interpreting'!

interpreting: type
	"Converts bytes from a binary source according to provided @type. It produces elements of corresponding class, e.g. #float -> Float, #double -> Double, etc. Supported types are defined by the Interpretations shared class variable.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		^		<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^self interpreting: type cacheSize: 1
!

interpreting: type cacheSize: size
	"Converts bytes from a binary source according to provided @type. It produces elements of corresponding class, e.g. #float -> Float, #double -> Double, etc. Supported types are defined on class side of InterpretedBytes.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via InterpretatedBytes)
		size		<Integer>	requested cache size (in number of elements)
		^		<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double cacheSize: 10)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^InterpretedReadStream on: self type: type cacheSize: size
!

interpreting: reader size: byteSize
	"Converts bytes from a binary source according to provided @reader block. The block is evaluated with an instance of InterpretedBytes and and index into it from which it should use byteSize bytes to make an object to return.
	""	reader		<BlockClosure>	reading block, e.g. [ :b :i | (b at: i) @ (b at: i + 1) ]
		byteSize	<Integer>	byte size of an element
		^			<InterpretedReadStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8) read: 5
	"
	^InterpretedReadStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: reader cacheSize: 1
!

interpreting: reader size: byteSize cacheSize: cacheSize
	"Converts bytes from a binary source according to provided @reader block. The block is evaluated with an instance of InterpretedBytes and and index into it from which it should use byteSize bytes to make an object to return.
	""	reader		<BlockClosure>	reading block, e.g. [ :b :i | (b at: i) @ (b at: i + 1) ]
		byteSize	<Integer>	byte size of an element
		cacheSize	<Integer>	requested cache size (in number of elements)
		^			<InterpretedReadStream>
	""
		| points bytes |
		points := Random new reading transforming: [ :in :out | out put: in get @ in get ].
		bytes := (ByteArray new writing interpreting: [ :b :i :o | (b floatAt: i put: o x) @ (b floatAt: i + 4 put: o y) ] size: 8 )
			write: 10 from: points;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8 cacheSize: 5) read: 5
	"
	^InterpretedReadStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: reader cacheSize: cacheSize
!

marshaling
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. A marshaling read stream decodes objects from a binary source previously encoded by a marshaling write stream.
	""	^	<ObjectReadSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := ByteArray new writing marshaling put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectReadStream on: self
!

marshaling: aMarshaler
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. Custom marshaling schemes can be derived by subclassing ObjectMarshaler. Custom schemes must declare their own (unique) version ID. This method allows to employ a cusomt marshaler instead of the default one (STST2.0).
	A marshaling read stream decodes objects from a binary source previously encoded by a marshaling write stream.
	""	aMarshaler	<ObjectMarshaler>	implements custom marshaling format
		^			<ObjectReadSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := (ByteArray new writing marshaling: ObjectMarshaler new) put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectReadStream on: self marshaler: aMarshaler
! !

!ReadStream methodsFor:'printing'!

printOn: aStream
	| stream |
	stream := String new writing.
	self streamingPrintOn: stream.
	aStream nextPutAll: stream conclusion.
	aStream cr.
	source printOn: aStream
!

streamingPrintOn: aStream
	aStream write: self class name
! !

!ReadStream methodsFor:'private'!

next
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."

	^self get
!

streamingInsert: anInteger into: aWriteStream
	aWriteStream streamingInsert: anInteger from: self
!

streamingInsertInto: aWriteStream
	^aWriteStream streamingInsertFrom: self
!

streamingWrite: anInteger into: aWriteStream
	^aWriteStream streamingWrite: anInteger from: self
!

streamingWriteInto: aWriteStream
	^aWriteStream streamingWriteFrom: self
! !

!ReadStream methodsFor:'seeking'!

++ anInteger
        "Seek forward by anInteger elements."
        "       anInteger       <Integer>       the number of elements to go forward by
                ^<Integer>      the number of elements skipped
        ""
                'Hello' reading ++ 2; rest
        "
        | count cache chunk read |
        anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
        anInteger = 0 ifTrue: [^0].
        count := 0.
        chunk := DefaultBufferSize min: anInteger.
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        [[count < anInteger] whileTrue:
                [read := chunk min: (anInteger - count).
                self read: read into: cache at: 1.
                count := count + read]]
                        on: Incomplete do: [ :ex | cache recycle. (Incomplete count: count + ex count) raise].
        cache recycle.
        ^anInteger
!

+= anInteger
	"Seek from the start of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go forward by."
	"
		'Hello' reading rest; += 2; rest
	"
	^self position: anInteger
!

-- anInteger
	"Seek backward by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go back by."
	"
		'hello' reading rest; -- 3; rest
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

-= anInteger
	"Seek backwards from the end of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       number of elements to go back by
		^<Integer>      number of elements actually skipped
	""
		'Hello' reading -= 3; rest
	"
	| available |
	(self isPositionable not and: [anInteger isZero]) ifTrue:
		["If we are attempting to skip to end and the stream is not positionable, skip forward until we hit an incomplete"
		[[self ++ SmallInteger maxVal] repeat] on: Incomplete do: [].
		^0 ].
	available := anInteger min: self length.
	self position: self length - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise
!

available
	"Return the number of elements available. The stream must be positionable."
	"       ^       <Integer>       the number of elements available"
	"
		'Hello' reading ++2; available
	"
	^self length - self position
!

explore: aBlock
        " Explore the stream within the block but return to where we started when the block completes. The stream must be positionable."
        "       aBlock  <BlockClosure>  defines the exploration activity
                ^               <Object>        result of aBlock"
        "
                'Hello' reading explore: [ :s | s -= 0 ]; rest
        "
        | position |
        position := self position.
        ^[aBlock cull: self] ensure: [self position: position]
!

length
	"Return total length of the stream. The stream must be positionable."
	"       ^       <Integer>       the total number of elements in the stream. (position + available)"
	"
		'Hello' reading read: 2; length
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

position
	"Return current position of the stream. The stream must be positionable."
	"       ^       <Integer>       the current position in the stream."
	"
		'Hello' reading read: 2; position
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

position: anInteger
	"Change position of the stream to anInteger. The stream must be positionable."
	"       anInteger       <Integer>       the position to set the stream at.
		^<Integer>      the position the stream was set to
	""
		'Hello' reading position: 2; rest
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
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
!

closing: aBlock
	^(PositionReadSubstream on: self)
		closeBlock: aBlock;
		yourself
!

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
!

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
!

limiting: limit
	"Create a substream that will allow at most @limit number of elements to be read from the source."
	"	limit		<Integer>	maximum number of elements that can be read from the source
		^<LimitReadStream>"
	"
		('abcdefghi' reading limiting: 5) rest
	"
	^LimitReadSubstream on: self limit: limit
!

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
!

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

!ReadStream methodsFor:'testing'!

isPositionable
	"Can this stream be positioned. Positionable streams support additional API: #position, #position:, ++, --, ..."

	^false
!

isReadable
	^true
!

isWritable
	^false
! !

!ReadStream methodsFor:'transforming'!

collecting: aBlock
	"Transform each element using #collect: style block."
	"	aBlock	<BlockClosure>	a #collect: style block used to tranform each element
		^<CollectReadSteam>
	""
		((1 to: 5) reading collecting: [ :e | e * e ]) rest
	""
		((65 to: 90) reading collecting: [ :e | e asCharacter ]) contentsSpecies: String; rest
	"
	^CollectReadStream on: self block: aBlock
!

depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]
!

doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectReadSteam>
	""
		((1 to: 5) reading doing: [ :e | Transcript space; print: e * e ]) rest
	"
	^self collecting: [:each | (aBlock value: each). each]
!

duplicating: aWriteStream
	"Duplicate all the contents written into @aWriteStream"
	"	aWriteStream <WriteStream>	a stream to copy into
		^<DuplicatingReadSteam>
	""
		| copy |
		copy := ByteArray new writing.
		((0 to: 15) reading duplicating: copy) rest -> copy conclusion
	"
	^DuplicateReadStream on: self duplicate: aWriteStream
!

encoding: anEncoding
	"Transform bytes into characters using @anEncoding such as #utf8 or #ascii, etc. Any encoding supported by StreamEncoder is allowed.
	The encoding steam also performs automatic line end conversion from arbitrary platform convention to CRs, unless set into a transparent mode"
	"	anEncoding	<Symbol> encoding identifier recognized by StreamEncoder class>>new:
		^<EncodedReadStream>
	""
		((65 to: 90) reading encoding: #ascii) rest
	""
		| crlf text |
		crlf := String with: Character cr with: Character lf.
		text := ('Hello', crlf, 'World') asByteArrayEncoding: #ascii.
		(text reading encoding: #ascii) rest.
		(text reading encoding: #ascii) setLineEndTransparent; rest
	"
	^EncodeReadStream on: self encoding: anEncoding
!

encodingBase64
	"Decodes characters of base-64 encoding into bytes. Ignores any intervening whitespace.
	Automatically ends the stream if it encounters final padding characters $=."
	"	^<TransformReadStream>"
	"
		'AAECAwQFBgcICQo= and the rest should be ignored' reading encodingBase64 rest
	"
	| map cache |
	map := [ :char | ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' indexOf: char) - 1 ].
	cache := ByteString new: 4.
	^(self transforming: [ :in :out || count end block filter |
		filter := in rejecting: #isSeparator.
		count := [ filter read: 4 into: cache at: 1. 4 ] on: Incomplete do: [ :incomplete | incomplete count].
		count isZero ifTrue: [ Incomplete zero raise ].
		(end := cache indexOf: $=) isZero ifFalse: [ count := count min: end - 1 ].
		count < 2 ifTrue: [ Incomplete zero signal ].
		block := (1 to: 4) inject: 0 into: [ :total :i || sextet |
			sextet := count < i ifTrue: [ 0 ] ifFalse: [ map value: (cache at: i) ].
			sextet negative ifTrue: [ count := i ].
			(total bitShift: 6) + sextet ].
		2 to: count do: [ :i | out put: ((block bitShift: (i - 4) * 8) bitAnd: 255) ].
		count < 4 ifTrue: [ (Incomplete count: count) raise ] ])
			buffer: (RingBuffer on: (ByteArray new: 3));
			yourself
!

encodingHex
	"Decodes bytes hex characters."
	"	^<TransformReadStream>"
	"
		(ByteArray withAll: (1 to: 20)) reading encodingHex rest
	"
	| i2c |
	i2c := [ :i | '0123456789abcdef' at: i + 1 ].
	^(self transforming: [ :in :out || byte |
		byte := in get.
		out put: (i2c value: (byte bitShift: -4)).
		out put: (i2c value: (byte bitAnd: 15)) ])
		contentsSpecies: ByteString;
		yourself
!

injecting: initialObject into: aBlock
	"Accumulates a running value combined with each passing element using the binary aBlock. aBlock takes the result of the last evaluation and the next element as its arguments. Notable difference from the collection analog is that the streaming variant is a stream of all the intermediate values of the running value."
	"	initialObject	<Object> initial value used as the previous result for the evaluation of the first element
		aBlock	<BlockClosure> binary block combining the value of each element with previous result of its evaluation
		^<CollectingReadStream>"
	"
		((1 to: 10) reading injecting: 0 into: [ :total :each | each + total ]) rest
	"
	| nextObject |
	nextObject := initialObject.
	^self collecting: [:each | nextObject := aBlock cull: nextObject cull: each]
!

monitoring: aNotificationBlock every: aNotificationInterval
	"Monitor the through-put of the receiver."
	"	aNotificationBlock <BlockClosure>	the block to execute when notifying
		aNotificationInterval <Duration>	how often to notify
		^<PositionReadSubstream>
	"

	"
		| monitor |
		monitor := ObjectMemory imageFilename reading
			monitoring: [:totalTransferred :deltaTransferred :elapsedMicroseconds |
				throughputSpeed := deltaTransferred.
				averageSpeed := (totalTransferred / elapsedMicroseconds) * 1000000.
				Transcript writing cr;
					write: 'average speed: '; print: averageSpeed asFloat;
					write: ' through-put speed: '; print: throughputSpeed asFloat;
					write: ' elapsed-time: '; print: elapsedMicroseconds / 1000000.0]
			every: 1 milliseconds.
		[monitor rest] ensure: [monitor close].
	"

	| previousPosition timer start notifyBlock monitoring notifyProcess notifyFinished |

	start := Time microsecondClock.
	previousPosition := 0.
	monitoring := nil.
	timer := nil.
	notifyFinished := false.

	notifyBlock := [
		aNotificationBlock cull: monitoring position cull: monitoring position - previousPosition cull: Time microsecondClock - start.
		previousPosition := monitoring position].

	notifyProcess := nil.
	notifyProcess := [
		[notifyBlock value. notifyFinished] whileFalse: [notifyProcess suspend]] newProcess.
	notifyProcess priority: ((Processor activeProcess priority + 1) min: 99).

	monitoring := self closing: [
		timer stop.
		notifyProcess resume.
		notifyFinished := true.
		notifyProcess resume.
		self close].

	timer := Timer every: aNotificationInterval resume: notifyProcess.
	^monitoring
!

pairing
	"Transform a stream of elements in to a stream of associations between even+odd elements of the stream. This expects the stream to have an even number of elements"

	^self transforming: [:in :out | out put: (Association key: in get value: in get)]
!

positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <ReadStream>    a positionable read stream
	""
		[ Time now ] reading positioning ++ 3; -- 2; get
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionReadStream on: self]
!

rejecting: aBlock
	"Filters elements from the source using aBlock. aBlock has the same form and semantics as the #reject: block on collections."
	"	aBlock	<BlockClosure>	usual #reject: style block used to filter the elements passing through
		^<TransformReadStream>"
	"
		((1 to: 10) reading rejecting: [ :e | e odd ]) rest
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileTrue.
		output put: value]
!

selecting: aBlock
	"Filters elements from the source using aBlock. aBlock has the same form and semantics as the #select: block on collections."
	"	aBlock	<BlockClosure>	usual #select: style block used to filter the elements passing through
		^<TransformReadStream>"
	"
		((1 to: 10) reading selecting: [ :e | e odd ]) rest
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileFalse.
		output put: value]
!

transforming: aBlock
	"This is the most general form of transform stream. The block receives two streams, the source (input) and a virtual stream of elements to be produced by the stream (output). The block can read arbitrary number of elements from input (including none) and write arbitrary number of elements into the output (including none). The block will be invoked as many times as necessary to produce the required number of elements, or until an Incomplete is raised. Consequently if the block handles Incomplete from the input, it has to raise another Incomplete at some point, otherwise the stream will never end.
	Note that if the contentSpecies of the source doesn't fit the output of the transformation, the contents species of the transform stream has to be set explicitly.
	""	aBlock	<BlockClosure>	binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
		^<TransformReadStream>
	""	Convert text into a stream of words
		('hello world!! bye world!!' reading transforming: [ :in :out || word char |
			word := String new writing.
			[	[  (char := in get) = Character space ] whileFalse: [ word put: char ].
			] ensure: [ out put: (word close; destination) ] ]
		)	contentsSpecies: Array;
			rest
	""	Convert a hex-string into a byte array (2 characters per byte)
		| c2d |
		c2d := [ :char | ('0123456789abcdef' indexOf: char) - 1 ].
		('0123456789abcdef' reading transforming: [ :in :out |
			out put: (c2d value: in get) * 16 + (c2d value: in get) ]
		)	buffer: (RingBuffer on: (ByteArray new: 1));
			rest
	"
	^TransformReadStream on: self block: aBlock
! !

!ReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ReadStream.st 12 2011-11-21 06:00:44Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

LibraryDefinition subclass:#stx_goodies_xtreams_core
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_core class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 12 2011-11-21 06:00:44Z mkobetic $'
! !

!stx_goodies_xtreams_core class methodsFor:'description'!

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
        #'stx:libbasic'    "Object - superclass of Xtreams::ReadStream "
    )
! !

!stx_goodies_xtreams_core class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'Xtreams::Buffer'
        #'Xtreams::Incomplete'
        #'Xtreams::ReadStream'
        #'Xtreams::WriteStream'
        #'Xtreams::stx_goodies_xtreams_core'
        #'Xtreams::PositionReadStream'
        #'Xtreams::PositionWriteStream'
        #'Xtreams::RingBuffer'
        #'Xtreams::ElasticBuffer'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        Object streamingInsert:into:
        Object streamingInsertInto:
        Object streamingPrintOn:
        Object streamingWrite:into:
        Object streamingWriteInto:
        SequenceableCollection streamingInsert:into:
        SequenceableCollection streamingInsertInto:
        SequenceableCollection streamingWrite:into:
        SequenceableCollection streamingWriteInto:
    )
! !

!stx_goodies_xtreams_core class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_core class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/core/stx_goodies_xtreams_core.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'30'"$"
! !

!stx_goodies_xtreams_core class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_core.st 12 2011-11-21 06:00:44Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

Object subclass:#Buffer
	instanceVariableNames:'cache readPosition writePosition dataLength'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core'
!

Buffer comment:'Buffer implements a buffering API over an in-memory cache. The cache will grow as required to fit new data in to the buffer. Two positions are kept, the read position and write position, allowing flexible usage of the buffer.

API:
	read:into:startingAt: -- reads data from the cache and moves readPosition forward
	write:into:startingAt: -- writes data into the cache and moves writePosition forward
	readSkip:/writeSkip: -- moves either readPosition or writePosition forward without changing the cache
	readPosition/readPosition:/writePosition/writePosition: -- accessors to the read/write positions
	clear -- remove all the data from the cache
	trim -- remove all the read data and all the empty space for writing in to from the cache

Instance Variables
	cache   <SequenceableCollection>        the cache for our buffer
	dataLength      <ArithmeticValue>       the amount of data in our cache, not the size of the cache
	readPosition    <ArithmeticValue>       the position within our data that we''re reading from (0..dataLength)
	writePosition   <ArithmeticValue>       the position within our data that we''re writing from (0..dataLength)

'
!


!Buffer class methodsFor:'instance creation'!

new: anInteger class: aClass
	^self on: (aClass newRecycled: anInteger)
!

on: aSequenceableCollection
	^self new on: aSequenceableCollection
! !

!Buffer methodsFor:'accessing'!

activeSize
	"The number of elements in the buffer that can be explored. This is <= cacheSize"

	^dataLength
!

cache
	^cache
!

cacheSize
	"The size of the cache, which is >= dataLength"

	^cache size
!

contentsFuture
	^cache copyFrom: readPosition + 1 to: readPosition + self readSize
!

contentsPast
	^cache copyFrom: 1 to: writePosition
!

inactiveSize
	"Free space to write in to"

	^cache size - dataLength
!

readSize
	"The number of elements available to read"

	^dataLength - readPosition
!

writeSize
	"The number of available slots to write in to, which might overwrite elements in dataLength; writeSize >= inactiveSize"

	^(cache size - writePosition + readPosition) min: cache size
! !

!Buffer methodsFor:'accessing - reading'!

get
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	readPosition := readPosition + 1.
	^cache at: readPosition
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := anInteger min: (dataLength - readPosition).
	aSequenceableCollection replaceFrom: startIndex to: startIndex + count - 1 with: cache startingAt: readPosition + 1.
	readPosition := readPosition + count.
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
!

readPosition
	^readPosition
!

readPosition: aPosition
	readPosition := (aPosition max: 0) min: dataLength
!

readSkip: anInteger
	| old delta |
	old := readPosition.
	self readPosition: old + anInteger.
	delta := readPosition - old.
	^delta
! !

!Buffer methodsFor:'accessing - writing'!

insert: aStreamable

	^aStreamable streamingInsertInto: self
!

insert: anInteger from: aStreamable

	^aStreamable streamingInsert: anInteger into: self
!

insert: anInteger from: aSequenceableCollection at: startIndex

	dataLength + anInteger <= cache size ifFalse: [self growBy: anInteger].

	cache replaceFrom: writePosition + anInteger + 1 to: dataLength + anInteger with: cache startingAt: writePosition + 1.
	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	dataLength := dataLength + anInteger.
	^anInteger
!

put: anObject

	writePosition < cache size ifFalse: [self growBy: 1].

	cache at: writePosition + 1 put: anObject.
	writePosition := writePosition + 1.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject
!

write: aStreamable

	^aStreamable streamingWriteInto: self
!

write: anInteger from: aStreamable

	^aStreamable streamingWrite: anInteger into: self
!

write: anInteger from: aSequenceableCollection at: startIndex

	writePosition + anInteger <= cache size ifFalse: [self growBy: anInteger].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
!

writePosition
	^writePosition
!

writePosition: aPosition
	^writePosition := (aPosition max: 0) min: dataLength
!

writeSkip: anInteger
	| old delta |
	old := writePosition.
	self writePosition: old + anInteger.
	delta := writePosition - old.
	^delta
! !

!Buffer methodsFor:'compressing'!

clear
	self clearCache.
	readPosition := writePosition := dataLength := 0
!

trim
	cache := cache copyFrom: readPosition + 1 to: writePosition.
	readPosition := 0.
	dataLength := writePosition := cache size
! !

!Buffer methodsFor:'converting'!

reading
	^BufferReadStream on: self
!

writing
	^BufferWriteStream on: self
! !

!Buffer methodsFor:'initialize-release'!

close
	dataLength := writePosition
!

contentsSpecies
	^cache species
!

on: aSequenceableCollection
	cache := aSequenceableCollection.
	dataLength := 0.
	readPosition := 0.
	writePosition := 0
!

recycle

	cache recycle
! !

!Buffer methodsFor:'printing'!

printOn: aStream
	| stream |
	stream := String new writing.
	self streamingPrintOn: stream.
	aStream nextPutAll: stream conclusion
!

streamingPrintOn: aStream
	aStream write: self class name;
		space; write: 'data: '; print: dataLength;
		space; write: 'read: '; print: self readPosition;
		space; write: 'write: '; print: self writePosition
! !

!Buffer methodsFor:'private'!

clearCache
	cache := cache copyEmpty: 0
!

growBy: anInteger
	| replacement |
	replacement := cache copyEmpty: (cache size + anInteger) * 2.
	replacement replaceFrom: 1 to: cache size with: cache startingAt: 1.
	cache := replacement
!

privateWrite: anInteger from: aSequenceableCollection at: startIndex
	" Ensure we're only doing with (writePosition + anInteger) <= cache size "
	(writePosition + anInteger) <= cache size ifFalse: [self error: 'invalid privateWrite. Use the #write: protocol instead.'].

	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	writePosition > dataLength ifTrue: [dataLength := writePosition]
!

streamingInsert: anInteger into: aWriteStream
	| count |
	count := (writePosition - readPosition) min: anInteger.
	count <= 0 ifTrue: [^0].
	aWriteStream insert: count from: cache at: readPosition + 1.
	self readSkip: count
!

streamingInsertInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingInsert: count into: aWriteStream.
	^count
!

streamingWrite: anInteger from: aReadStream
	"Implementing this method would allow the buffer to be treated like a stream sometimes. Currently this is not implemented, make a buffer stream on your buffer instead."
	self error: 'not yet implemented'
!

streamingWrite: anInteger into: aWriteStream
	| count |
	count := (writePosition - readPosition) min: anInteger.
	count <= 0 ifTrue: [^0].
	aWriteStream write: count from: cache at: readPosition + 1.
	self readSkip: count.
	^count
!

streamingWriteFrom: aReadStream
	"Implementing this method would allow the buffer to be treated like a stream sometimes. Currently this is not implemented, make a buffer stream on your buffer instead."
	self error: 'not yet implemented'
!

streamingWriteInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingWrite: count into: aWriteStream.
	^count
! !

!Buffer methodsFor:'testing'!

hasDataToRead
	^readPosition < dataLength
!

hasFixedWriteSpace
	^false
!

hasSpaceToWrite
	^true
! !

!Buffer class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__Buffer.st 8 2011-08-22 15:58:01Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

Buffer subclass:#RingBuffer
	instanceVariableNames:'dataPosition'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core'
!

RingBuffer comment:'RingBuffer is a specialized buffer that has a fixed sized cache. The cache is treated as ring/circle, such that when we get to the end of the cache, we continue reading and writing data from the beginning of the cache. If you write more data than you have written, the unread data is lost. The readPosition and writePosition are always relative to the dataPosition, which is a hidden implementation detail.

Instance Variables
	dataPosition    <ArithmeticValue>       the position in our cache where our data starts

'
!


!RingBuffer methodsFor:'accessing'!

contentsFuture
	| buffer read tail |
	cache isEmpty ifTrue: [^self contentsSpecies new].
	read := (dataPosition + readPosition) \\ cache size.
	tail := (cache size - read) min: self readSize.

	buffer := self contentsSpecies withSize: self readSize.
	buffer replaceFrom: 1 to: tail with: cache startingAt: read + 1.
	buffer replaceFrom: tail + 1 to: self readSize - tail with: cache startingAt: 1.
	^buffer
!

contentsPast
	| buffer tail |
	cache isEmpty ifTrue: [^self contentsSpecies new].
	tail := (cache size - dataPosition) min: self writePosition.

	buffer := self contentsSpecies withSize: self writePosition.
	buffer replaceFrom: 1 to: tail with: cache startingAt: dataPosition + 1.
	buffer replaceFrom: tail + 1 to: buffer size with: cache startingAt: 1.
	^buffer
! !

!RingBuffer methodsFor:'accessing - reading'!

get
	| read |
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	read := (dataPosition + readPosition) \\ cache size.
	readPosition := readPosition + 1.
	^cache at: read + 1
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count read tail |

	count := anInteger min: (dataLength - readPosition).
	read := (dataPosition + readPosition) \\ cache size.
	tail := (cache size - read) min: count.

	aSequenceableCollection replaceFrom: startIndex to: startIndex + tail - 1 with: cache startingAt: read + 1.
	aSequenceableCollection replaceFrom: startIndex + tail to: startIndex + count - 1 with: cache startingAt: 1.
	readPosition := readPosition + count.

	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!RingBuffer methodsFor:'accessing - writing'!

insert: anInteger from: aSequenceableCollection at: startIndex

	| tail write temp length position |
	length := dataLength - writePosition.
	write := (dataPosition + writePosition + 1) \\ cache size.
	tail := (cache size - write) min: length.
	temp := self contentsSpecies newRecycled: (length max: DefaultBufferSize).
	temp replaceFrom: 1 to: tail with: cache startingAt: write.
	temp replaceFrom: tail + 1 to: length with: cache startingAt: 1.
	dataLength := dataLength - length.
	self write: anInteger from: aSequenceableCollection at: startIndex.
	position := self writePosition.
	self write: length from: temp.
	self writePosition: position.
	temp recycle.
	^anInteger
!

put: anObject
	| write |

	write := (dataPosition + writePosition) \\ cache size.
	cache at: write + 1 put: anObject.

	self privateWrapDataPosition: 1.
	writePosition := (writePosition + 1) min: cache size.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex

	anInteger < cache size ifTrue:  [self privateWrite: anInteger from: aSequenceableCollection at: startIndex. ^anInteger].

	" Do the quick store, since we're a ring "
	dataPosition := readPosition := 0.
	dataLength := writePosition := cache size.
	cache replaceFrom: 1 to: cache size with: aSequenceableCollection startingAt: startIndex + anInteger - cache size.
	^anInteger
! !

!RingBuffer methodsFor:'compressing'!

clear
	super clear.
	dataPosition := 0
!

trim
	| read write |
	read := (dataPosition + readPosition) \\ cache size.
	write := (dataPosition + writePosition) \\ cache size.
	read <= write
		ifTrue: [cache := cache copyFrom: read + 1 to: write + 1]
		ifFalse:
			[ | replacement readSize |
			readSize := cache size - read.
			replacement := cache copyEmpty: write + readSize.
			replacement replaceFrom: 1 to: readSize with: cache startingAt: read + 1.
			replacement replaceFrom: readSize + 1 to: replacement size with: cache startingAt: write + 1.
			cache := replacement].
	dataPosition := readPosition := 0.
	dataLength := writePosition := cache size
! !

!RingBuffer methodsFor:'initialize-release'!

on: aSequenceableCollection
	super on: aSequenceableCollection.
	dataPosition := 0
! !

!RingBuffer methodsFor:'private'!

clearCache
!

growBy: anInteger
	self shouldNotImplement
!

privateWrapDataPosition: anInteger
"       inflatedLength <= cache size --- do nothing
	inflatedLength >   cache size --- move dataPosition and readPosition
"
	| inflatedLength overflow |

	inflatedLength := writePosition + anInteger.
	inflatedLength <= cache size ifTrue: [^self].
	overflow := inflatedLength - cache size.
	readPosition := (readPosition - overflow) max: 0.
	dataPosition := (dataPosition + overflow) \\ cache size
!

privateWrite: anInteger from: aSequenceableCollection at: startIndex
	| write tail |

	anInteger > 0 ifFalse: [^self].
	" Ensure we're only doing with anInteger <= cache size "
	anInteger > cache size ifTrue: [self error: 'invalid privateWrite. Use the #write: protocol instead.'].

	write := (dataPosition + writePosition) \\ cache size.
	tail := (cache size - write) min: anInteger.

	cache replaceFrom: write + 1 to: write + tail with: aSequenceableCollection startingAt: startIndex.
	cache replaceFrom: 1 to: anInteger - tail with: aSequenceableCollection startingAt: startIndex + tail.

	self privateWrapDataPosition: anInteger.
	writePosition := (writePosition + anInteger) min: cache size.
	writePosition > dataLength ifTrue: [dataLength := writePosition]
!

streamingInsert: anInteger into: aWriteStream

	| read amount tail head |
	amount := (dataLength - readPosition) min: anInteger.
	read := (dataPosition + readPosition) \\ cache size.
	tail := cache size - read min: amount.
	head := amount - tail.
	aWriteStream insert: tail from: cache at: read + 1.
	head <= 0 ifTrue: [^self readSkip: tail].
	aWriteStream insert: head from: cache at: 1.
	self readSkip: tail + head
!

streamingInsertInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingInsert: count into: aWriteStream.
	^count
!

streamingWrite: anInteger into: aWriteStream

	| read amount tail head |
	amount := (dataLength - readPosition) min: anInteger.
	read := (dataPosition + readPosition) \\ cache size.
	tail := cache size - read min: amount.
	head := amount - tail.
	aWriteStream write: tail from: cache at: read + 1.
	head <= 0 ifTrue: [self readSkip: tail. ^anInteger].
	aWriteStream write: head from: cache at: 1.
	self readSkip: tail + head.
	^anInteger
!

streamingWriteInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingWrite: count into: aWriteStream.
	^count
! !

!RingBuffer methodsFor:'testing'!

hasFixedWriteSpace
	^true
!

hasSpaceToWrite
	^self writeSize isZero not
! !

!RingBuffer class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__RingBuffer.st 3 2011-08-22 15:42:51Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#PositionReadStream
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core'
!

PositionReadStream comment:'Wraps a non-positionable stream and provides positioning capability by buffering read elements. Buffering strategy can be configured via different Buffer classes.

Instance Variables
	buffer  <Buffer> holds read elements

'
!


!PositionReadStream methodsFor:'accessing'!

get
	| object |
	buffer hasDataToRead ifTrue: [^buffer get].
	object := source get.
	buffer put: object.
	buffer readSkip: 1.
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex

	^[      buffer read: anInteger into: aSequenceableCollection at: startIndex. anInteger
	] on: Incomplete do: [:exception || bufferCount sourceCount |
		bufferCount := exception count.
		sourceCount := anInteger - bufferCount.
		[source read: sourceCount into: aSequenceableCollection at: startIndex + exception count]
			on: Incomplete do: [:incomplete | sourceCount := incomplete count].
		buffer write: sourceCount from: aSequenceableCollection at: startIndex + bufferCount.
		buffer readSkip: sourceCount.
		(sourceCount + bufferCount) < anInteger ifTrue: [
			(Incomplete on: aSequenceableCollection count: sourceCount + bufferCount at: startIndex) raise].
		anInteger ]
! !

!PositionReadStream methodsFor:'initialize-release'!

buffer
	^buffer
!

buffer: aBuffer

	buffer recycle.
	buffer := aBuffer
!

close
	super close.
	buffer recycle.
	buffer := nil
!

contentsSpecies
	^source contentsSpecies
!

on: aSource
	buffer := Buffer new: DefaultBufferSize class: aSource contentsSpecies.
	super on: aSource
! !

!PositionReadStream methodsFor:'printing'!

streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		write: ' buffered: ';
		print: buffer readSize.
	buffer readSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsFuture
! !

!PositionReadStream methodsFor:'seeking'!

++ anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	skipped := buffer readSkip: anInteger.
	skipped = anInteger ifTrue: [^anInteger].
	[super ++ (anInteger - skipped)] on: Incomplete do: [:incomplete |
		(Incomplete count: incomplete count + skipped) raise].
	^anInteger
!

-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer readSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise
!

length
	"advance to the end"
	[ [ self ++ SmallInteger maxVal ] repeat ] on: Incomplete do: [ :ex | ].
	^buffer activeSize
!

position
	^buffer readPosition
!

position: aPosition

	| startPosition delta |
	aPosition < 0 ifTrue: [Incomplete zero raise].
	startPosition := buffer readPosition.
	delta := aPosition - startPosition.
	^[      self ++ delta. aPosition
	] on: Incomplete do: [ :ex |
		(Incomplete count: startPosition + ex count) raise ]
! !

!PositionReadStream methodsFor:'testing'!

isPositionable
	^true
! !

!PositionReadStream methodsFor:'transforming'!

positioning
	^self
! !

!PositionReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionReadStream.st 3 2011-08-22 15:42:51Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

RingBuffer subclass:#ElasticBuffer
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core'
!

ElasticBuffer comment:'ElasticBuffer is a variation on a ring buffer that will grow if it has no room to write the data in to its cache. It will split the cache and insert new elements if necessary, otherwise it will wrap around like a regular ring buffer. You have a slightly more liberal ''rewind'' policy than the RingBuffer such that if you read data, then write data, it will only overwrite the read data if the write data can fit in to that space, otherwise it will grow the cache.

'
!


!ElasticBuffer methodsFor:'accessing - writing'!

put: anObject

	self writeSize < 1 ifTrue: [self growBy: 1].
	^super put: anObject
!

write: anInteger from: aSequenceableCollection at: startIndex

	anInteger <= self writeSize ifFalse: [self growBy: anInteger - self writeSize].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
! !

!ElasticBuffer methodsFor:'private'!

clearCache
	cache := cache copyEmpty: 0
!

growBy: anInteger
	| split replacement growth |
	split := dataPosition + writePosition.
	cache size isZero ifFalse: [split := split \\ cache size].
	split isZero ifTrue: [split := cache size].
	growth := cache size + anInteger + anInteger.
	replacement := cache copyEmpty: cache size + growth.
	replacement replaceFrom: 1 to: split with: cache startingAt: 1.
	replacement replaceFrom: split + growth + 1 to: replacement size with: cache startingAt: split + 1.
	cache := replacement.
	split <= dataPosition ifTrue: [dataPosition := dataPosition + growth]
! !

!ElasticBuffer methodsFor:'testing'!

hasFixedWriteSpace
	^false
!

hasSpaceToWrite
	^true
! !

!ElasticBuffer class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ElasticBuffer.st 3 2011-08-22 15:42:51Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

Object subclass:#WriteStream
	instanceVariableNames:'destination'
	classVariableNames:'Backspace Bell CarriageReturn Delete DoubleQuote Escape FormFeed
		LineFeed Quote Space Tab VerticalTab'
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core'
!

WriteStream comment:'Abstract superclass of all write streams; defines the API.

Write streams are created by sending #writing to a concrete resource (a.k.a terminal), such as a Collection, SocketAccessor, Filename, etc.

	String new writing write: ''testing''; close; terminal

Transform write streams are created through one of the messages in the ''transforming'' protocol sent to other write streams.

	(String new writing collecting: #asUppercase) write: ''testing''; close; terminal

Subclasses must implement the following messages:
	#read:into:at:
	#contentsSpecies

Instance Variables
	destination     <Object> a stream or "terminal" consuming written elements

Shared Variables
	Backspace       <Character>
	Bell    <Character>
	CarriageReturn  <Character>
	Delete  <Character>
	DoubleQuote     <Character>
	Escape  <Character>
	FormFeed        <Character>
	LineFeed        <Character>
	Quote   <Character>
	Space   <Character>
	Tab     <Character>
	VerticalTab     <Character>

'
!


!WriteStream class methodsFor:'instance creation'!

on: aDestination
	^self new on: aDestination
! !

!WriteStream class methodsFor:'class initialization'!

initialize
        Backspace := String with: Character backspace.
        Bell := String with: (Character value: 7).
        CarriageReturn := String with: (Character value: 13).
        Delete := String with: (Character value: 127).
        DoubleQuote := String with: $".
        Escape := String with: (Character value: 27).
        FormFeed := String with: Character newPage.
        LineFeed := String with: Character lf.
        Quote := String with: $'.
        Space := String with: Character space.
        Tab := String with: Character tab.
        VerticalTab := String with: (Character value: 11)
! !

!WriteStream methodsFor:'accessing'!

conclusion
	"Close the stream and return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure> "
	self close.
	^self terminal
!

destination

	^destination
!

insert: aStreamable
	"Insert aStreamable into self at current position."
	"       aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      the number of elements written to the destination"
	"
		' World!!' copy writing insert: 'Hello' reading; -= 0; close; destination
	"
	^aStreamable streamingInsertInto: self
!

insert: anInteger from: aStreamable
	"Insert anIntegers worth of elements from aStreamable into self at current position."
	"       anInteger       <Integer>       the number of elements to insert
		aStreamable     <ReadStream | SequenceableCollection | Buffer > the source to write into the destination
		startIndex      <Integer>       the index into aSequenceableCollection to start writing from
		^<Integer>      number of elements inserted
	""
		' World!!' copy writing insert: 5 from: 'Hello Underworld!!' reading; -= 0; close; destination
	"
	aStreamable streamingInsert: anInteger into: self.
	^anInteger
!

insert: anInteger from: aSequenceableCollection at: startIndex
	"Insert anIntegers worth of elements from aSequenceableCollection starting at startIndex into self at current position."
	"       anInteger       <Integer>       the number of elements to insert
		aStreamable     <SequenceableCollection>        the source to write into the destination
		startIndex      <Integer>       the index into aSequenceableCollection to start writing from
		^<Integer>      number of elements inserted
	""
		' World!!' copy writing insert: 5 from: 'Hello' at: 1; -= 0; close; destination
	"
	self write: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
!

put: anObject
	"Write anObject into self."
	"       anObject                <Object>        the object to write in to the destination
		^                               <Object>        the object that was written to the destination
	""
		String new writing put: $h; close; destination
	"
	| cache |
	cache := self contentsSpecies newRecycled: 1.
	cache at: 1 put: anObject.
	self write: 1 from: cache at: 1.
	cache recycle.
	^anObject
!

terminal
	"Return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(destination isKindOf: WriteStream)
		ifTrue: [ destination terminal ]
		ifFalse: [ destination ]
!

write: aStreamable
	"Write aStreamable into self."
	"       aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      the number of elements written to the destination"
	"
		String new writing write: 'Hello' reading; close; destination
	"
	^aStreamable streamingWriteInto: self
!

write: anInteger from: aStreamable
	"Write anInteger's worth of elements from aStreamable into self."
	"       anInteger       <Integer>       the number of elements to write
		aStreamable     <SequenceableCollection | ReadStream | Buffer>  the source to write in to the destination
		^<Integer>      number of elements written
	""
		String new writing write: 3 from: 'Hello' reading; close; destination
	"
	^aStreamable streamingWrite: anInteger into: self
!

write: anInteger from: aSequenceableCollection at: startIndex
	"Write anIntegers worth of elements from aSequenceableCollection starting at startIndex into self."
	"       anInteger       <Integer>       the number of elements to write
		aStreamable     <SequenceableCollection>        the source to write in to the destination
		startIndex      <Integer>       the index into aSequenceableCollection to start writing from
		^<Integer>      number of elements written
	""
		String new writing write: 3 from: 'Hello' at: 2; close; destination
	"
	^self subclassResponsibility
! !

!WriteStream methodsFor:'characters'!

backspace
	self write: Backspace
!

bell
	self write: Bell
!

cr
	self write: CarriageReturn
!

delete
	self write: Delete
!

escape
	self write: Escape
!

ff
	self write: FormFeed
!

lf
	self write: LineFeed
!

print: anObject
	anObject streamingPrintOn: self
!

q
	self write: Quote
!

qq
	self write: DoubleQuote
!

space
	self write: Space
!

space: anInteger
	anInteger timesRepeat: [self space]
!

tab
	self write: Tab
!

tab: anInteger
	anInteger timesRepeat: [self tab]
!

vtab
	self write: VerticalTab
! !

!WriteStream methodsFor:'converting'!

writing
	^[:object | self nextPut: object] writing
		contentsSpecies: self contentsSpecies;
		yourself
! !

!WriteStream methodsFor:'initialize-release'!

close
	"Close the destination from any more writes."

	self flush.
	destination close
!

contentsSpecies
	"The class of collection that is able to hold the kind of elements that this stream consumes."
	"       ^       <Class> collection class
	"
	^self subclassResponsibility
!

flush
	"Make sure all the previously written elements are pushed down into the destination."
	destination flush
!

on: aDestination
	destination := aDestination
! !

!WriteStream methodsFor:'interpreting'!

interpreting: type
	"Converts consumed elements into bytes of pre-configured (primitive) CType, e.g. float, long etc. The type of the written elements must match the CType and the underlying destination must be binary.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		^		<InterpretedWriteStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^self interpreting: type cacheSize: 1
!

interpreting: type cacheSize: size
	"Converts consumed elements into bytes of pre-configured (primitive) CType, e.g. float, long etc. The type of the written elements must match the CType and the underlying destination must be binary.
	""	type	<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		size		<Integer>	requested buffer size (in number of elements)
		^		<InterpretedWriteStream>
	""
		| doubles bytes |
		doubles := [ Random new next ] reading.
		bytes := (ByteArray new writing interpreting: #double size: 10)
			write: 10 from: doubles;
			close;
			terminal.
		(bytes reading interpreting: #double) read: 10
	"
	^InterpretedWriteStream on: self type: type cacheSize: size
!

interpreting: writer size: byteSize
	"Converts objects into bytes in a binary destination according to provided @writer block. The block is evaluated with an instance of InterpretedBytes an index and object to write into the bytes.
	""	type		<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		byteSize	<Integer>	byte size of an element
		^			<InterpretedWriteStream>
	""
		| points bytes |
		points := Random new reading transforming: [ :in :out | out put: in get @ in get ].
		bytes := (ByteArray new writing interpreting: [ :b :i :o | (b floatAt: i put: o x) @ (b floatAt: i + 4 put: o y) ] size: 8 )
			write: 10 from: points;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8 cacheSize: 5) read: 5
	"
	^InterpretedWriteStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: writer cacheSize: 1
!

interpreting: writer size: byteSize cacheSize: cacheSize
	"Converts objects into bytes in a binary destination according to provided @writer block. The block is evaluated with an instance of InterpretedBytes an index and object to write into the bytes.
	""	type		<Symbol>	identifies a (primitive) CType, e.g. #float, #long (mapped via Interpretations)
		byteSize	<Integer>	byte size of an element
		cacheSize	<Integer>	requested cache size (in number of elements)
		^			<InterpretedWriteStream>
	""
		| points bytes |
		points := Random new reading transforming: [ :in :out | out put: in get @ in get ].
		bytes := (ByteArray new writing interpreting: [ :b :i :o | (b floatAt: i put: o x) @ (b floatAt: i + 4 put: o y) ] size: 8 )
			write: 10 from: points;
			close;
			terminal.
		(bytes reading interpreting: [ :b :i | (b floatAt: i) @ (b floatAt: i + 4) ] size: 8 cacheSize: 5) read: 5
	"
	^InterpretedWriteStream on: self bytesPerElement: byteSize contentsSpecies: Array operation: writer cacheSize: cacheSize
!

marshaling
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID.
	A marshaling write stream encodes objects into a binary destination stream.
	""	^			<ObjectWriteSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := ByteArray new writing marshaling put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectWriteStream on: self
!

marshaling: aMarshaler
	"Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. Custom marshaling schemes can be derived by subclassing ObjectMarshaler. Custom schemes must declare their own (unique) version ID. This method allows to employ a cusomt marshaler instead of the default one (STST2.0).
	A marshaling write stream encodes objects into a binary destination stream.
	""	aMarshaler	<ObjectMarshaler>	implements custom marshaling format
		^			<ObjectWriteSteam>
	""
		| rectangle bytes |
		rectangle := 5 @ 5 extent: 5 @ 5.
		bytes := (ByteArray new writing marshaling: ObjectMarshaler new) put: rectangle; conclusion.
		bytes reading marshaling get
	"
	^ObjectWriteStream on: self marshaler: aMarshaler
! !

!WriteStream methodsFor:'printing'!

printOn: aStream
	| stream |
	stream := String new writing.
	self streamingPrintOn: stream.
	aStream nextPutAll: stream conclusion.
	aStream cr.
	destination printOn: aStream.
!

streamingPrintOn: aStream
	aStream write: self class name
! !

!WriteStream methodsFor:'private'!

nextPut: anObject
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."
	self put: anObject.
	^anObject
!

nextPutAll: aCollection
	"This is here for compatibility with the existing StreamEncoders so that they can be re-used with transformation streams for encoding."
	self write: aCollection.
	^aCollection
!

streamingInsert: anInteger from: aReadStream
        | cache count |
        cache := self contentsSpecies newRecycled: (anInteger max: DefaultBufferSize).
        count := [aReadStream read: anInteger into: cache at: 1. anInteger] on: Incomplete do: [ :ex | ex count ].
        self insert: count from: cache at: 1.
        cache recycle.
        count < anInteger ifTrue: [(Incomplete count: count) raise]
!

streamingInsertFrom: aReadStream
        | count cache |
        count := 0.
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        [[aReadStream read: cache size into: cache at: 1] on: Incomplete do: [:exception |
                self insert: exception.
                cache recycle.
                ^count + exception count].
        self insert: cache size from: cache at: 1.
        count := count + cache size] repeat
!

streamingWrite: anInteger from: aReadStream
        | cache toDo continue amount |
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        toDo := anInteger. continue := true.
        [ continue and: [ toDo > 0 ] ] whileTrue: [
                amount := [ aReadStream read: (cache size min: toDo) into: cache at: 1 ] on: Incomplete do: [ :ex | continue := false. ex count ].
                self write: amount from: cache at: 1.
                toDo := toDo - amount ].
        cache recycle.
        toDo > 0 ifTrue: [(Incomplete count: anInteger - toDo) raise].
        ^anInteger
!

streamingWriteFrom: aReadStream
        | count cache |
        count := 0.
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        [[aReadStream read: cache size into: cache at: 1] on: Incomplete do: [:exception |
                self write: exception.
                cache recycle.
                ^count + exception count].
        self write: cache size from: cache at: 1.
        count := count + cache size] repeat
! !

!WriteStream methodsFor:'seeking'!

++ anInteger
	"Seek forward by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       the number of elements to go forward by.
		^<Integer>      the number of elements actually skipped
	"
	"
		'Hello Would' copy writing ++ 6; write: 'World'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [Incomplete zero raise]
		ifTrue: [self subclassResponsibility]
!

+= anInteger
	"Seek from the start of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go forward by."
	"
		String new writing write: 'Hello Would'; += 6; write: 'World'; close; destination
	"
	^self position: anInteger
!

-- anInteger
	"Seek backward by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go back by."
	"
		String new writing write: 'helio'; -- 2; write: 'lo'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

-= anInteger
	"Seek backwards from the end of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go back by.
		^<Integer>      the number of elements actually skipped"
	"
		'Hello Would' copy writing -= 3; write: 'rld'; close; terminal
	"
	| available |
	available := anInteger min: self length.
	self position: self length - available.
	available = anInteger ifTrue: [ ^anInteger ].
	^(Incomplete count: available) raise
!

available
	"Return the number of elements from the current position to the end of the stream. The stream must be positionable."
	"       ^       <Integer>       the number of elements available"
	"
		String new writing write: 'Hello World'; -- 5; available
	"
	^self length - self position
!

explore: aBlock
	" Explore the stream within the block but return to where we started when the block completes. The stream must be positionable."
	"       aBlock  <BlockClosure>  defines the exploration activity
		^               <Object>        result of aBlock"
	"
		String new writing explore: [ :s | s write: 'Hello' ]; write: 'World'; close; destination
	"
	| position |
	position := self position.
	^[aBlock cull: self] ensure: [self position: position]
!

length
	"Return total length of the stream. The stream must be positionable."
	"       ^       <Integer>       the total number of elements in the stream. (position + available)"
	"
		'Hello World' copy writing ++ 5; length
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

position
	"Return current position of the stream. The stream must be positionable."
	"       ^       <Integer>       current position of the stream."
	"
		'Hello World' copy writing -= 5; position
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
!

position: anInteger
	"Change current position of the stream to anInteger. The stream must be positionable."
	"       anInteger       <Integer>       current position of the stream."
	"
		'Hello Would' copy writing position: 6; write: 'World'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
! !

!WriteStream methodsFor:'substreaming'!

closing: aBlock
	^(PositionWriteSubstream on: self)
		closeBlock: aBlock;
		yourself
!

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
!

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
!

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
!

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
!

stitching
	^self error: 'You can only stitch a read stream, however that read stream can return write streams and in so doing, you will create a stitching write stream.'
! !

!WriteStream methodsFor:'testing'!

isPositionable
	"Can this stream be positioned. Positionable streams come with extra API: #position, #position:, etc."

	^false
!

isReadable
	^false
!

isWritable
	^true
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
!

collecting: aBlock
	"Transform each written element using #collect: style block."
	"	aBlock	<BlockClosure>	a #collect: style block used to tranform each element
		^<CollectWriteSteam>
	""
		(Array new writing collecting: [ :e | e * e ]) write: (1 to: 5); conclusion
	""
		(String new writing collecting: [ :e | e asCharacter ]) write: (65 to: 90); conclusion
	"
	^CollectWriteStream on: self block: aBlock
!

depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]
!

doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectWriteSteam>
	""
		(Array new writing doing: [ :e | Transcript space; print: e * e ]) write: (1 to: 10); conclusion
	"
	^self collecting: [:each | (aBlock value: each). each]
!

duplicating: aWriteStream
	"Duplicate all the contents written into @aWriteStream"
	"	aWriteStream <WriteStream>	a stream to copy into
		^<DuplicateWriteSteam>
	""
		| original copy |
		original := Array new writing.
		copy := ByteArray new writing.
		(original duplicating: copy) write: (0 to: 15).
		original conclusion -> copy conclusion
	"
	^DuplicateWriteStream on: self duplicate: aWriteStream
!

encoding: anEncoding
	"Transform characters into bytes using @anEncoding such as #utf8 or #ascii, etc. Any encoding supported by StreamEncoder is allowed.
	The encoding steam also performs automatic conversion of CRs into the native line-end convention of the underlying platform,
	unless set into a different line-end convention mode"
	"	anEncoding	<Symbol> encoding identifier recognized by StreamEncoder class>>new:
		^<EncodedWriteStream>
	""
		(ByteArray new writing encoding: #ascii) write: 'abcdefghi'; conclusion
	""
		(ByteArray new writing encoding: #ascii) write: 'Hello\World' withCRs; conclusion
	""
		(ByteArray new writing encoding: #ascii) setLineEndCRLF; write: 'Hello\World' withCRs; conclusion
	"
	^EncodeWriteStream on: self encoding: anEncoding
!

encodingBase64
	"Encodes bytes into characters of base-64 encoding.
	Emits final padding characters ($=) as required, when the stream is closed."
	"	^<TransformWriteStream>"
	"
		String new writing encodingBase64 write: (ByteArray withAll: (1 to: 20)); conclusion
	"
	| map cache |
	map := [ :i | 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' at: i + 1 ].
	cache := ByteArray new: 3.
	^(self transforming: [ :in :out | | count block shift |
		count := [ in read: 3 into: cache at: 1. 3 ] on: Incomplete do: [ :incomplete | incomplete count].
		count isZero ifTrue: [ Incomplete zero raise ].
		block := (1 to: count) inject: 0 into: [ :total :byte | (total bitShift: 8) + (cache at: byte)].
		shift := count * -8.
		1 to: count + 1 do: [:i | out put: (map value: ((block bitShift: (shift + (i * 6))) bitAnd: 63))].
		count < 3 ifTrue: [
			3 - count timesRepeat: [ out put: $= ].
			(Incomplete count: count) raise]])
		buffer: (RingBuffer on: (ByteArray new: 3));
		yourself
!

encodingHex
	"Encodes hex characters into bytes."
	"	^<TransformReadStream>"
	"
		ByteArray new writing encodingHex write: '010203fdfeff'; terminal
	"
	| c2i |
	c2i := [ :c | ('0123456789abcdef' indexOf: c asLowercase) - 1 ].
	^(self transforming: [ :in :out |
		out put: ((c2i value: in get) bitShift: 4) + (c2i value: in get) ])
		contentsSpecies: ByteString;
		yourself
!

injecting: initialObject into: aBlock
	"Accumulates a running value combined with each passing element using the binary aBlock. aBlock takes the result of the last evaluation and the next element as arguments. Notable difference from the collection analog is that the streaming variant is a stream of all the intermediate values of the running value."
	"	initialObject	<Object> initial value used as the previous result for the evaluation of the first element
		aBlock	<BlockClosure> binary block combining the value of each element with previous result of its evaluation
		^<CollectingWriteStream>"
	"
		(Array new writing injecting: 0 into: [ :total :each | each + total ]) write: (1 to: 10); conclusion
	"
	| nextObject |
	nextObject := initialObject.
	^self collecting: [:each | nextObject := aBlock cull: nextObject cull: each]
!

monitoring: aNotificationBlock every: aNotificationInterval
	"Monitor the through-put of the receiver."
	"	aNotificationBlock <BlockClosure>	the block to execute when notifying
		aNotificationInterval <Duration>	how often to notify
		^<PositionWriteSubstream>
	"

	| previousPosition timer start notifyBlock monitoring notifyProcess notifyFinished |

	start := Time microsecondClock.
	previousPosition := 0.
	monitoring := nil.
	timer := nil.
	notifyFinished := false.

	notifyBlock := [
		aNotificationBlock cull: monitoring position cull: monitoring position - previousPosition cull: Time microsecondClock - start.
		previousPosition := monitoring position].

	notifyProcess := nil.
	notifyProcess := [
		[notifyBlock value. notifyFinished] whileFalse: [notifyProcess suspend]] newProcess.
	notifyProcess priority: ((Processor activeProcess priority + 1) min: 99).

	monitoring := self closing: [
		timer stop.
		notifyProcess resume.
		notifyFinished := true.
		notifyProcess resume.
		self close].

	timer := Timer every: aNotificationInterval resume: notifyProcess.
	^monitoring
!

pairing
	"Transform a stream of elements in to a stream of associations between even+odd elements of the stream. This expects the stream to have an even number of elements"

	^self transforming: [:in :out | out put: (Association key: in get value: in get)]
!

positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <WriteStream>   a positionable read stream
	""
		[ :x | Transcript space; print: x ] writing positioning write: (1 to: 10); -- 5; write: (11 to: 15); close
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionWriteStream on: self]
!

rejecting: aBlock
	"Filters written elements using aBlock. aBlock has the same form and semantics as the #reject: block on collections."
	"	aBlock	<BlockClosure>	usual #reject: style block used to filter the elements passing through
		^<TransformWriteStream>"
	"
		(Array new writing rejecting: [ :e | e odd ]) write: (1 to: 10); conclusion
	"
	^self selecting: [:each | (aBlock cull: each) not]
!

selecting: aBlock
	"Filters written elements using aBlock. aBlock has the same form and semantics as the #select: block on collections."
	"	aBlock	<BlockClosure>	usual #select: style block used to filter the elements passing through
		^<TransformWriteStream>"
	"
		(Array new writing selecting: [ :e | e odd ]) write: (1 to: 10); conclusion
	"
	^self transforming: [:input :output |
		| value |
		[value := input get.
		aBlock cull: value] whileFalse.
		output put: value]
!

transforming: aBlock
	"This is the most general form of transform stream. The block receives two streams, a virtual stream of written elements (input) and the destination (output). The block can read arbitrary number of elements from input (including none) and write arbitrary number of elements into the output (including none). The block will be invoked as many times as necessary to consume any written elements, or until an Incomplete is raised by the destination.
	Note that if the #contentSpecies of the destination doesn't fit the input of the transformation, the #contentsSpecies of the transform stream has to be set explicitly.
	""	aBlock	<BlockClosure>	binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
		^<TransformWriteStream>
	""	Convert text into a stream of words
		(Array new writing transforming: [ :in :out || word char |
			word := String new writing.
			[	[  (char := in get) = Character space ] whileFalse: [ word put: char ].
			] ensure: [ out put: (word close; destination) ] ]
		)	write: 'hello world!! bye world!!';
			close;
			terminal
	""	Convert a hex-string into a byte array (2 characters per byte)
		| c2d |
		c2d := [ :char | ('0123456789abcdef' indexOf: char) - 1 ].
		(ByteArray new writing transforming: [ :in :out |
			out put: (c2d value: in get) * 16 + (c2d value: in get) ]
		)	contentsSpecies: String;
			write: '0123456789abcdef';
			close;
			terminal
	"
	^TransformWriteStream on: self block: aBlock
! !

!WriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__WriteStream.st 8 2011-08-22 15:58:01Z mk $'
! !

WriteStream initialize!
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

Error subclass:#Incomplete
	instanceVariableNames:'collection count start'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core'
!

Incomplete comment:'This error is raised when a read or write fails to complete. The parameters report the details about successfully written or read elements.

Instance Variables
	collection      <Collection | nil> when possible points at the collection with the successfully processed elements
	count   <Integer> number of successfully processed elements
	start   <Integer> if collection is set, this is the index where the successfully processed elements start

'
!


!Incomplete class methodsFor:'instance creation'!

count: anInteger
	^self new on: nil count: anInteger at: nil
!

on: collection count: count at: start
	^self new on: collection count: count at: start
!

zero
	^self count: 0
! !

!Incomplete methodsFor:'accessing'!

collection
	^collection
!

collection: anObject
	collection := anObject
!

contents
	^collection
		ifNil: [ self originator contentsSpecies withSize: count ]
		ifNotNil: [ collection copyFrom: start to: start + count - 1 ]
!

count
	^count
!

count: anObject
	count := anObject
!

start
	^start
!

start: anObject
	start := anObject
! !

!Incomplete methodsFor:'initialize-release'!

on: aCollection count: aCount at: aStart
	collection := aCollection.
	count := aCount.
	start := aStart
! !

!Incomplete methodsFor:'private'!

streamingInsert: anInteger into: aWriteStream
	| amount |
	collection ifNil: [(self class on: collection count: 0 at: start) raise].
	amount := anInteger min: count.
	aWriteStream insert: amount from: collection at: start.
	amount < anInteger ifTrue: [(self class on: collection count: amount at: start) raise].
!

streamingInsertInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream insert: count from: collection at: start.
	^count
!

streamingWrite: anInteger into: aWriteStream
	| amount |
	collection ifNil: [(self class on: collection count: 0 at: start) raise].
	amount := anInteger min: count.
	aWriteStream write: amount from: collection at: start.
	amount < anInteger ifTrue: [(self class on: collection count: amount at: start) raise].
	^anInteger
!

streamingWriteInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream write: count from: collection at: start.
	^count
! !

!Incomplete class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__Incomplete.st 3 2011-08-22 15:42:51Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:05 PM'                  !

"{ Package: 'stx:goodies/xtreams/core' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#PositionWriteStream
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core'
!

PositionWriteStream comment:'Wraps a non-positionable stream and provides positioning capability by buffering written elements. Buffering strategy can be configured via different Buffer classes.

Instance Variables
	buffer  <Buffer> holds written elements

'
!


!PositionWriteStream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex
	^buffer insert: anInteger from: aSequenceableCollection at: startIndex
!

write: anInteger from: aSequenceableCollection at: startIndex

	| toFlush bufferFlush |
	(buffer hasFixedWriteSpace not or: [buffer writeSize >= anInteger ]) ifTrue: [
		buffer write: anInteger from: aSequenceableCollection at: startIndex.
		^anInteger ].
	toFlush := buffer readSize + anInteger - buffer cacheSize.
	bufferFlush := toFlush min: buffer readSize.
	destination write: bufferFlush from: buffer.
	(toFlush > bufferFlush) ifTrue: [
		toFlush := toFlush - bufferFlush.
		destination write: toFlush from: aSequenceableCollection at: startIndex ].
	buffer write: anInteger - toFlush from: aSequenceableCollection at: startIndex + toFlush.
	^anInteger
! !

!PositionWriteStream methodsFor:'initialize-release'!

buffer

	^buffer
!

buffer: aBuffer

	buffer recycle.
	buffer := aBuffer
!

close
	super close.
	buffer recycle.
	buffer := nil
!

contentsSpecies
	^destination contentsSpecies
!

flush
	buffer ifNil: [^self].
	destination write: buffer.
	buffer clear
!

on: aDestination
	buffer := Buffer new: DefaultBufferSize class: aDestination contentsSpecies.
	super on: aDestination
! !

!PositionWriteStream methodsFor:'printing'!

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

!PositionWriteStream methodsFor:'seeking'!

++ anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	skipped := buffer writeSkip: anInteger.
	skipped = anInteger ifTrue: [^anInteger].
	[destination ++ (anInteger - skipped)] on: Incomplete do: [:incomplete |
		(Incomplete count: incomplete count + skipped) raise].
	^anInteger
!

-- anInteger
	| skipped |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	skipped := (buffer writeSkip: anInteger negated) negated.
	skipped = anInteger ifTrue: [^anInteger].
	(Incomplete count: skipped) raise
!

available
	^buffer writeSize
!

length
	^buffer activeSize
!

position
	^buffer writePosition
!

position: aPosition
	| startPosition delta |
	aPosition < 0 ifTrue: [Incomplete zero raise].
	startPosition := buffer writePosition.
	delta := aPosition - startPosition.
	^[      self ++ delta. aPosition
	] on: Incomplete do: [ :ex |
		(Incomplete count: startPosition + ex count) raise ]
! !

!PositionWriteStream methodsFor:'testing'!

isPositionable
	^true
! !

!PositionWriteStream methodsFor:'transforming'!

positioning
	^self
! !

!PositionWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionWriteStream.st 3 2011-08-22 15:42:51Z mk $'
! !
!SequenceableCollection methodsFor:'private'!

streamingInsert: anInteger into: aWriteStream
	aWriteStream insert: anInteger from: self at: 1
! !

!SequenceableCollection methodsFor:'private'!

streamingInsertInto: aWriteStream
	aWriteStream insert: self size from: self at: 1.
	^self size
! !

!SequenceableCollection methodsFor:'private'!

streamingWrite: anInteger into: aWriteStream
	^aWriteStream write: anInteger from: self at: 1
! !

!SequenceableCollection methodsFor:'private'!

streamingWriteInto: aWriteStream
	aWriteStream write: self size from: self at: 1.
	^self size
! !

!Object methodsFor:'private'!

streamingInsert: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingInsertInto: aWriteStream]
! !

!Object methodsFor:'private'!

streamingInsertInto: aWriteStream
	aWriteStream insert: (aWriteStream contentsSpecies with: self)
! !

!Object methodsFor:'private'!

streamingPrintOn: aWriteStream
	aWriteStream write: self printString
! !

!Object methodsFor:'private'!

streamingWrite: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingWriteInto: aWriteStream].
	^anInteger
! !

!Object methodsFor:'private'!

streamingWriteInto: aWriteStream
	aWriteStream put: self
! !

