'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#InterpretedReadStream
	instanceVariableNames:'elementSize cache cacheSize operation contentsSpecies'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

InterpretedReadStream comment:'Interprets bytes from a binary source as values of preconfigured (primitive) CType, e.g. float, long etc.

Instance Variables
	elementSize	<Integer> byte size of elements of the pre-configured CType
	cache	<InterpretedBytes> caches bulk read bytes before interpreting for speed; size = elementSize * cacheSize
	cacheSize	<SmallInteger> how many elements (not bytes) do we want to cache
	operation	<BlockClosure> CType translation primitive used to read from the buffer
	contentsSpecies	<Class> collection type to use to hold collections of elements

'
!


!InterpretedReadStream class methodsFor:'instance creation'!

on: aReadStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	^self new on: aReadStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
!

on: aReadStream type: aSymbol cacheSize: anInteger
	| interpretation |
	interpretation := InterpretedBytes perform: aSymbol.
	^self on: aReadStream bytesPerElement: (interpretation at: 1) contentsSpecies: (interpretation at: 2) operation: (interpretation at: 3) cacheSize: anInteger
! !

!InterpretedReadStream methodsFor:'accessing'!

read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |
	count := 0.
	[[count = anInteger] whileFalse:
		[amount := cacheSize min: (anInteger - count).
		source read: amount * elementSize into: cache at: 1.
		0 to: amount - 1 do: [:index | aSequenceableCollection at: startIndex + count + index put: (operation value: cache value: index * elementSize + 1)].
		count := count + amount]]
			on: Incomplete do: [:exception |
				0 to: exception count // elementSize - 1 do: [:index | aSequenceableCollection at: startIndex + count + index put: (operation value: cache value: index * elementSize + 1)].
				(Incomplete on: aSequenceableCollection count: count + (exception count / elementSize) at: startIndex) raise].
	^anInteger
! !

!InterpretedReadStream methodsFor:'initialize-release'!

close
	super close.
	cache recycle.
	cache := nil
!

contentsSpecies
	^contentsSpecies
!

on: aReadStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	super on: aReadStream.
	cacheSize := aSize.
	elementSize := anInteger.
	contentsSpecies := aClass.
	operation := aBlock.
	cache := InterpretedBytes newRecycled: ((elementSize * cacheSize) max: DefaultBufferSize)
! !

!InterpretedReadStream methodsFor:'seeking'!

++ anInteger

	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	[source ++ anInteger * elementSize]
		on: Incomplete do: [:exception | (Incomplete count: exception count / elementSize) raise].
	^anInteger
!

-- anInteger
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	[source -- anInteger * elementSize]
		on: Incomplete do: [:exception | (Incomplete count: exception count / elementSize) raise].
	^anInteger
!

length
	^source length / elementSize
!

position
	^source position / elementSize
!

position: aPosition

	^([ source position: aPosition * elementSize ] on: Incomplete do: [ :ex | ex count ]) // elementSize
! !

!InterpretedReadStream methodsFor:'testing'!

isPositionable

	^source isPositionable
! !

!InterpretedReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__InterpretedReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#ObjectReadStream
	instanceVariableNames:'marshaler objects float double nothing uint16 uint32 uint64 int64
		int8 int16 int32'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

ObjectReadStream comment:'Unmarshals objects from binary source, previously marshaled using the same ObjectMarshaler. The bytes must start with marshaler version ID.

Instance Variables
	marshaler	<ObjectMarshaler> performs marshaling of object bodies
	objects	<Array> retains unmarshaled objects for resolution of backward references (to preserve identity)
	longs	<InterpretedReadStream> (internal) for reading of longs
	longlongs	<InterpretedReadStream> (internal) for reading of longlongs
	floats	<InterpretedReadStream> (internal) for reading of floats
	doubles	<InterpretedReadStream> (internal) for reading of doubles
	nothing	<Object> (internal) an object used to occupy empty slots in objects (since nil is potentially valid content)

'
!


!ObjectReadStream class methodsFor:'instance creation'!

on: aDestination
	^self on: aDestination marshaler: ObjectMarshaler new
!

on: aDestination marshaler: aMarshaler
	^self new on: aDestination marshaler: aMarshaler
! !

!ObjectReadStream methodsFor:'accessing'!

get
	| object |
	object := marshaler unmarshal: self.
	self complete.
	^object
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[anInteger timesRepeat:
		[aSequenceableCollection at: startIndex + count put: (marshaler unmarshal: self).
		self complete.
		count := count + 1]]
			on: Incomplete do: [:exception |
				self complete.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!ObjectReadStream methodsFor:'initialize-release'!

contentsSpecies
	^Array
!

on: aSource marshaler: aMarshaler
	super on: aSource.
	marshaler := aMarshaler.
	objects := Array with: false with: Transcript.
	nothing := Object new.

	int8 := aSource interpreting: #signedChar.
	(marshaler configureUnmarshal: aSource)
		ifTrue: [
			int16 := aSource interpreting: #signedShort_be.
			int32 := aSource interpreting: #signedLong_be.
			int64 := aSource interpreting: #signedLonglong_be.
			uint16 := aSource interpreting: #unsignedShort_be.
			uint32 := aSource interpreting: #unsignedLong_be.
			uint64 := aSource interpreting: #unsignedLonglong_be]
		ifFalse: [
			int16 := aSource interpreting: #signedShort_le.
			int32 := aSource interpreting: #signedLong_le.
			int64 := aSource interpreting: #signedLonglong_le.
			uint16 := aSource interpreting: #unsignedShort_le.
			uint32 := aSource interpreting: #unsignedLong_le.
			uint64 := aSource interpreting: #unsignedLonglong_le].
	float := aSource interpreting: #float.
	double := aSource interpreting: #double
! !

!ObjectReadStream methodsFor:'primitives'!

double
	^double
!

float
	^float
!

int16
	^int16
!

int32
	^int32
!

int64
	^int64
!

int8
	^int8
!

uint16
	^uint16
!

uint32
	^uint32
!

uint64
	^uint64
!

uint8
	^source
! !

!ObjectReadStream methodsFor:'private'!

complete
	1 to: objects size by: 2 do: [:index |
		objects at: index put: false.
		objects at: index + 1 put: nothing].
	objects at: 2 put: Transcript
!

grow: index
	| replacement |
	(replacement := Array new: index)
		replaceFrom: 1 to: objects size with: objects startingAt: 1.
	objects size + 1 to: index by: 2 do: [:i |
		replacement
			at: i put: false;
			at: i + 1 put: nothing].
	objects := replacement
!

nothing
	^nothing
!

objects
	^objects
! !

!ObjectReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ObjectReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#ObjectWriteStream
	instanceVariableNames:'marshaler objects nothing int16 int32 int64 uint16 uint32 uint64
		float double int8'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

ObjectWriteStream comment:'Marshals objects into a binary destination using the associated ObjectMarshaler. The marshaler version ID is emited at the beginning.

Instance Variables
	marshaler	<ObjectMarshaler> performs marshaling of object bodies
	objects	<Array> retains unmarshaled objects for resolution of backward references (to preserve identity)
	longs	<InterpretedReadStream> (internal) for reading of longs
	longlongs	<InterpretedReadStream> (internal) for reading of longlongs
	floats	<InterpretedReadStream> (internal) for reading of floats
	doubles	<InterpretedReadStream> (internal) for reading of doubles
	nothing	<Object> (internal) an object used to occupy empty slots in objects (since nil is potentially valid content)

'
!


!ObjectWriteStream class methodsFor:'instance creation'!

on: aDestination
	^self on: aDestination marshaler: ObjectMarshaler new
!

on: aDestination marshaler: aMarshaler
	^self new on: aDestination marshaler: aMarshaler
! !

!ObjectWriteStream methodsFor:'accessing'!

put: object
	marshaler marshal: self object: object.
	self complete.
	^object
!

write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: anInteger + startIndex - 1 do: [:index |
		marshaler marshal: self object: (aSequenceableCollection at: index).
		self complete].
	^anInteger
! !

!ObjectWriteStream methodsFor:'initialize-release'!

contentsSpecies
	^Array
!

on: aDestination marshaler: aMarshaler
	super on: aDestination.
	marshaler := aMarshaler.
	objects := Array with: Transcript.
	nothing := Object new.

	int8 := aDestination interpreting: #signedChar.
	(marshaler configureMarshal: aDestination)
		ifTrue: [
			int16 := aDestination interpreting: #signedShort_be.
			int32 := aDestination interpreting: #signedLong_be.
			int64 := aDestination interpreting: #signedLonglong_be.
			uint16 := aDestination interpreting: #unsignedShort_be.
			uint32 := aDestination interpreting: #unsignedLong_be.
			uint64 := aDestination interpreting: #unsignedLonglong_be]
		ifFalse: [
			int16 := aDestination interpreting: #signedShort_le.
			int32 := aDestination interpreting: #signedLong_le.
			int64 := aDestination interpreting: #signedLonglong_le.
			uint16 := aDestination interpreting: #unsignedShort_le.
			uint32 := aDestination interpreting: #unsignedLong_le.
			uint64 := aDestination interpreting: #unsignedLonglong_le].
	float := aDestination interpreting: #float.
	double := aDestination interpreting: #double
! !

!ObjectWriteStream methodsFor:'primitives'!

double
	^double
!

float
	^float
!

int16
	^int16
!

int32
	^int32
!

int64
	^int64
!

int8
	^int8
!

uint16
	^uint16
!

uint32
	^uint32
!

uint64
	^uint64
!

uint8
	^destination
! !

!ObjectWriteStream methodsFor:'private'!

complete
	objects atAllPut: nothing.
	objects at: 1 put: Transcript
!

grow
	objects := objects copyWith: nothing
!

nothing
	^nothing
!

objects
	^objects
! !

!ObjectWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ObjectWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

Object subclass:#ObjectMarshaler
	instanceVariableNames:'classes read write version rehash analyse immediate classesMutex'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

ObjectMarshaler comment:'Marshaler defines the binary format for various object types it is meant to support. This one defines generic marshaling format for arbitrary Smaltalk objects, named STST 2.0. It is used as the default marshaler for marshaling streams. It is designed to be reasonably compact and fast to marshal / unmarshal. Objects have no persistent identity between transactions, but do within a transaction to allow for recursion.

Record Format:
	<class record> <object record>

Class Format:
	Class name is only included if this is the first reference to a class id that isn''t known by the terminals.
	<class id : integer> (<class absoluteName : string> <class isMeta : 0 = false, 1 = true>)?

Object Format:
	Object id is not included if the object is an immediate, in which case the object body is always included.
	Object body is not included if the object is has previously been shared between the terminals in this transaction.
	<object id : integer>? <object body>?		

Object Body Formats:
	integers:
		0 .. 252											one byte
		-2147483647 .. 2147483648						four bytes
		-9223372036854775807 .. 9223372036854775808	eight bytes
		larger integers									a stringified base 36 number
		float												four bytes
		double											eight bytes

	true / false / nil:
		No space beyond the record entry

	class:
		A repeat of the Class Format

	characters:
		<character : integer>

	strings:
		<string size : integer> <characters : character>*

	bytes:
		<byte array size: integer> <bytes : one byte>*

	collection:
		<collection size : integer> <elements : record>*

	dictionary / keyed collection:
		<dictionary size : integer> (<key : record> <value : record>)*

	object:
		The basicSize is only included if the object class isVariable
		<basicSize : integer>? <instance variables : record)* (basic variables : record)*

Example Records:
	true:		21 (true)
	128:		19 (SmallInteger) 128
	''test'':		4 (ByteString) 1 (object id) 4 (string length) 116 $t 101 $e 115 $s 116 $t
	5 asValue:
		23 (ValueHolder) 29 (class name length) ...29.. (''Root.Smalltalk.UI.ValueHolder'') 0 (not meta) 1 (object id)
			22 (nil)
			19 (SmallInteger) 5
	(5 @ 6):
		18 (Point) 1 (object id)
			19 (SmallInteger) 5
			19 (SmallInteger) 6
	(Array with: 5 asValue with: 5 asValue):
		1 (Array) 1 (object id) 2 (array length)
			23 (ValueHolder) 29 (class name length) ...29.. (''Root.Smalltalk.UI.ValueHolder'') 0 (not meta) 2 (object id)
				22 (nil)
				19 (SmallInteger) 5
			23 (ValueHolder) 3 (object id)
				22 (nil)
				19 (SmallInteger) 5

Instance Variables
	classes	<Array of: Class> maps class IDs to classes
	read	<Dictionary key: Class value: Symbol> maps classes to methods to use to unmarshal
	write	<Dictionary key: Class value: Symbol> maps classes to methods to use to marshal
	version	<ByteArray> version id, e.g. (STST 2.0)
	rehash	<Array of: Class> list of classes that need to be rehashed after unmarshaling
	analyse	<Array of: Symbol> maps class IDs to corresponding analysing method selector
	immediate	<Array of: Boolean> maps class IDs to value of #hasImmediateInstances for that class

'
!


!ObjectMarshaler class methodsFor:'instance creation'!

new
	^super new initialize
! !

!ObjectMarshaler class methodsFor:'pragmas'!

pragmas
	<pragmas: #instance>
	^#( #reads: #analyse: #writes: )
! !

!ObjectMarshaler methodsFor:'analyse - complex'!

analyse: reading binding: aClass
	<analyse: 'Core.VariableBinding'>

	| binding isInStandardEnvironment |
	reading
		log: ['binding: ', binding]
		do: [isInStandardEnvironment := self unmarshal: reading.
			binding := self get: reading string: String.
			isInStandardEnvironment ifFalse:
				[reading log: 'value' do: [self analyse: reading].
				reading log: 'environment' do: [self analyse: reading]]]
!

analyse: reading bytes: aClass
	<analyse: 'Core.ByteArray'>

	| bytes |
	reading log: ['bytes: ', bytes printString] do: [bytes := self get: reading bytes: aClass]
!

analyse: reading class: aClass
	<analyse: 'Core.Behavior'>

	| classId class  |
	reading
		log:	['class: ', class absoluteName]
		do:	[classId := self analyse: reading class_id: [:id :behavior | classId := id. class := behavior]]
!

analyse: reading class_id: aBlock
	| id class className classIsMeta classFormat classInstVarSize classInstVarNames |
	id := -1.
	reading log: ['class id: ', id printString] do: [id := self get: reading integer: nil].
	id > classes size ifFalse: [^aBlock value: id value: (classes at: id)].
	class := nil.
	reading log: ['class description: ', class fullName] do:
		[className := self get: reading string: String.
		classIsMeta := self unmarshal: reading.
		classFormat := self get: reading integer: Integer.
		classInstVarSize := self get: reading integer: Integer.
		classInstVarNames := (1 to: classInstVarSize) collect: [:i | self get: reading string: String].
		classesMutex critical: [
			class := self resolveClass: className isMeta: classIsMeta format: classFormat instVarNames: classInstVarNames.
			self includeClass: class]].
	^aBlock value: id value: class
!

analyse: reading collection: aClass
	<analyse: 'Core.Collection'>
	<analyse: 'Core.OrderedCollection'>
	<analyse: 'Core.Array'>
	<analyse: 'Core.Set'>

	| size |
	reading log: ['collection: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat: [self analyse: reading]]
!

analyse: reading compiledcode: aClass
	<analyse: 'Kernel.CompiledCode'>

	reading log: 'compiled code: ', aClass fullName do: [
		| variableSize allInstVarNames |
		variableSize := aClass isVariable
			ifTrue:	[self get: reading integer: nil]
			ifFalse:	[0].

		allInstVarNames := aClass allInstVarNames.
		1 to: aClass instSize do: [:index | reading log: (allInstVarNames at: index) do: [self analyse: reading]].
		1 to: variableSize do: [:index | reading log: index printString do: [self analyse: reading]]]
!

analyse: reading dictionary: aClass
	<analyse: 'Core.Dictionary'>
	<analyse: 'Core.KeyedCollection'>

	| size |
	reading log: ['dictionary: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat:
			[self analyse: reading.
			self analyse: reading]]
!

analyse: reading interval: aClass
	<analyse: 'Core.Interval'>

	reading log: ['interval: ', aClass fullName] do: [
		self analyse: reading.
		self analyse: reading.
		self analyse: reading]
!

analyse: reading linkedlist: aClass
	<analyse: 'Core.LinkedList'>

	| size |
	reading log: ['linkedlist: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat: [self analyse: reading]]
!

analyse: reading namespace: aClass
	<analyse: 'Kernel.NameSpace'>

	| namespace |
	^reading log: ['namespace: ', namespace absoluteName] do: [namespace := (self get: reading string: String) asStrictReference value]
!

analyse: reading object: aClass
	<analyse: 'Core.Object'>

	reading log: 'object: ', aClass fullName do: [
		| variableSize allInstVarNames |
		variableSize := aClass isVariable
			ifTrue:	[self get: reading integer: nil]
			ifFalse:	[0].

		allInstVarNames := aClass allInstVarNames.
		1 to: aClass instSize do: [:index | reading log: (allInstVarNames at: index) do: [self analyse: reading]].
		1 to: variableSize do: [:index | reading log: index printString do: [self analyse: reading]]]
!

analyse: reading point: aClass
	<analyse: 'Core.Point'>

	reading log: 'point' do:
		[reading log: 'x:' do: [self analyse: reading].
		reading log: 'y:' do: [self analyse: reading]]
!

analyse: reading sortedCollection: aClass
	<analyse: 'Core.SortedCollection'>

	| size |
	size := 0.
	reading log: ['sorted collection: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		reading log: ['sort block'] do: [self analyse: reading].
		size timesRepeat: [self analyse: reading]]
!

analyse: reading string: aClass
	<analyse: 'Core.String'>
	<analyse: 'Core.ByteString'>
	<analyse: 'Core.TwoByteString'>
	<analyse: 'Core.FourByteString'>

	| string |
	reading log: ['string: ', string printString] do: [string := self get: reading string: aClass]
!

analyse: reading symbol: aClass
	<analyse: 'Core.Symbol'>
	<analyse: 'Core.ByteSymbol'>
	<analyse: 'Core.TwoByteSymbol'>
	<analyse: 'Core.FourByteSymbol'>

	| symbol |
	reading log: ['symbol: ', symbol printString] do: [symbol := self get: reading symbol: aClass]
!

analyse: reading variablePool: aClass
	<analyse: 'Tools.WorkspaceVariablePool'>

	reading log: ['variable pool'] do:
		[reading log: 'import' do: [self get: reading string: String].
		reading log: 'bindings' do: [self analyse: reading]].
! !

!ObjectMarshaler methodsFor:'analyse - core'!

analyse: reading character: aClass
	<analyse: 'Core.Character'>

	| character |
	reading log: ['character: ', character printString] do: [character := self get: reading character: aClass]
!

analyse: reading false: boolean
	<analyse: 'Core.False'>

	reading log: 'false' do: [self get: reading false: boolean]
!

analyse: reading nil: undefined
	<analyse: 'Core.UndefinedObject'>

	reading log: 'nil' do: [self get: reading nil: undefined]
!

analyse: reading true: boolean
	<analyse: 'Core.True'>

	reading log: 'true' do: [self get: reading true: boolean]
! !

!ObjectMarshaler methodsFor:'analyse - numbers'!

analyse: reading double: aClass
	<analyse: 'Core.Double'>

	| double |
	reading log: ['double: ', double printString] do: [double := self get: reading double: aClass]
!

analyse: reading float: aClass
	<analyse: 'Core.Float'>

	| float |
	reading log: ['float: ', float printString] do: [float := self get: reading float: aClass]
!

analyse: reading integer: aClass
	<analyse: 'Core.Integer'>
	<analyse: 'Core.SmallInteger'>
	<analyse: 'Core.LargePositiveInteger'>
	<analyse: 'Core.LargeNegativeInteger'>

	| indicator integer |
	integer := nil.
	reading log: [integer ifNil: ['integer'] ifNotNil: ['byte integer: ', integer printString]] do: [
		indicator := self get: reading byte: nil.
		indicator < 252 ifTrue: [integer := indicator. ^indicator].
		indicator = 255 ifTrue: [^self analyse: reading integerNegativeLarge: aClass].
		indicator = 254 ifTrue: [^self analyse: reading integerPositiveLarge: aClass].
		indicator = 253 ifTrue: [^self analyse: reading integerMedium: aClass].
		indicator = 252 ifTrue: [^self analyse: reading integerSmall: aClass]]
!

analyse: reading integerMedium: aClass
	| integer |
	reading log: ['medium integer: ', integer printString] do: [integer := self get: reading integerMedium: aClass]
!

analyse: reading integerNegativeLarge: integer
	reading log: 'large negative integer' do: [self get: reading integerLarge: integer]
!

analyse: reading integerPositiveLarge: integer
	reading log: 'large positive integer' do: [self get: reading integerLarge: integer]
!

analyse: reading integerSmall: aClass
	| integer |
	reading log: ['small integer: ', integer printString] do: [integer := self get: reading integerSmall: aClass]
! !

!ObjectMarshaler methodsFor:'api'!

analyse: reading
	| description |
	description := '<error>'.
	reading
		log:
			[description]
		do:
			[ | classId class objectId |
			self analyse: reading class_id: [:id :behavior |
				description := 'class id: ', id printString, ' class: ', behavior fullName, ' '.
				classId := id.
				class := behavior].
			(immediate at: classId) ifTrue:
				[description := description, 'immediate'.
				self perform: (analyse at: classId) with: reading with: class.
				^self].
			objectId := -1.
			reading log: ['object id: ', objectId printString] do: [objectId := self get: reading integer: nil].
			(reading objects includes: objectId) ifTrue:
				[description := description, 'reference: ', objectId printString.
				^self].
			description := description, 'object id: ', objectId printString.
			reading objects add: objectId.
			self perform: (analyse at: classId) with: reading with: class.
			(rehash at: classId) ifTrue: [description := description, ' rehash']]
!

marshal: writing object: object
	| class classId objectId |
	class := object class.
	classId := self put: writing class: class.

	(immediate at: classId) ifTrue: [^self perform: (write at: classId) with: writing with: object].
	(objectId := writing objects identityIndexOf: object) isZero ifTrue:
		[(objectId := writing objects identityIndexOf: writing nothing) isZero ifTrue:
			[writing grow.
			objectId := writing objects size].
		writing objects at: objectId put: object.
		self put: writing integer: objectId.
		^self perform: (write at: classId) with: writing with: object].
	self put: writing integer: objectId
!

unmarshal: reading
	| object reference classId class objectIndex referenceIndex |
	self get: reading class_id: [:id :behavior | classId := id. class := behavior].
	(immediate at: classId) ifTrue: [^self perform: (read at: classId) with: reading with: class].
	objectIndex := (self get: reading integer: nil) * 2.
	referenceIndex := objectIndex - 1.
	objectIndex > reading objects size ifTrue: [reading grow: objectIndex].
	(object := reading objects at: objectIndex) ~~ reading nothing ifTrue:
		[reading objects at: referenceIndex put: true.
		^object].
	reading objects at: objectIndex put: (reference := Object new).
	object := self perform: (read at: classId) with: reading with: class.
	(rehash at: classId) ifTrue: [object rehash].
	^(reading objects at: referenceIndex)
		ifTrue:	[reference become: object. reference]
		ifFalse:	[reading objects at: objectIndex put: object. object]
! !

!ObjectMarshaler methodsFor:'configuration'!

configureAnalyse: reading
	"Negotiate this marshaler on the reading stream and return true if the stream should be big-endian."

	(reading read: version size) = version ifFalse: [self error: 'incompatible marshalers'].
	^reading get = true coerceToCInteger
!

configureMarshal: writing
	"Negotiate this marshaler on the writing stream and return true if the stream should be big-endian."

	writing
		write: version;
		put: InterpretedBytes isBigEndian coerceToCInteger;
		flush.
	^InterpretedBytes isBigEndian
!

configureUnmarshal: reading
	"Negotiate this marshaler on the reading stream and return true if the stream should be big-endian."

	(reading read: version size) = version ifFalse: [self error: 'incompatible marshalers'].
	^reading get = true coerceToCInteger
! !

!ObjectMarshaler methodsFor:'initialize-release'!

includeClass: aClass
	| class classId |
	class := aClass.
	[(classId := classes indexOf: class) isZero] whileTrue: [class := class superclass].
	classes := classes copyWith: aClass.
	read := read copyWith: (read at: classId).
	write := write copyWith: (write at: classId).
	analyse := analyse copyWith: (analyse at: classId).
	rehash := rehash copyWith: (rehash at: classId).
	immediate := immediate copyWith: aClass hasImmediateInstances.
	^classes size
!

initialize
	self initializeVersion.
	classesMutex := Semaphore forMutualExclusion.
	classes := Array new.

	read := Array new.
	(Pragma allNamed: #reads: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		classes := classes copyWith: pragma arguments first asStrictReference value.
		read := read copyWith: pragma selector].

	analyse := Array new: classes size.
	(Pragma allNamed: #analyse: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		| class id |
		class := pragma arguments first asStrictReference value.
		(id := classes indexOf: class) isZero
			ifTrue:
				[classes := classes copyWith: class.
				read := read copyWith: nil.
				analyse := analyse copyWith: pragma selector]
			ifFalse:
				[analyse at: id put: pragma selector]].

	write := Array new: classes size.
	(Pragma allNamed: #writes: from: self class to: ObjectMarshaler sortedByArgument: 1) do: [:pragma |
		| class id |
		class := pragma arguments first asStrictReference value.
		(id := classes indexOf: class) isZero
			ifTrue:
				[classes := classes copyWith: class.
				read := read copyWith: nil.
				analyse := analyse copyWith: nil.
				write := write copyWith: pragma selector]
			ifFalse:
				[write at: id put: pragma selector]].

	rehash := Array new: classes size.
	classes keysAndValuesDo: [:index :class | rehash at: index put: (class canUnderstand: #rehash)].

	immediate := Array new: classes size.
	classes keysAndValuesDo: [:index :class | immediate at: index put: class hasImmediateInstances].

	"true, false and nil are not immediate in the #isImmediate sense, but they are in the bytes sense"
	immediate
		at: (classes indexOf: UndefinedObject) put: true;
		at: (classes indexOf: True) put: true;
		at: (classes indexOf: False) put: true
!

initializeVersion
        | hash versionWriting |
        version := #[83 84 83 84 20]. "STST 2.0"
        hash := self class absoluteName hash.
        (self class methodDictionary keys asSortedCollection: [:a :b | (a compareCollatingWith: b) <= 0]) do: [:key |
                hash := (hash bitXor: key hash) bitXor: (self class methodDictionary at: key) byteCode hash].

        versionWriting := ByteArray new writing.
        versionWriting write: version.
        versionWriting write: hash digitLength.
        [hash > 0] whileTrue: [versionWriting write: (hash bitAnd: 255). hash := hash bitShift: -8].
        version := versionWriting conclusion
!

resolveClass: className isMeta: classIsMeta format: classFormat instVarNames: classInstVarNames
	"If a class by the absolute name of className exists, and its shape and format match what was expected, re-use it, otherwise create a shadow-class."

	| class newMetaclass |
	class := className asStrictReference valueOrDo: [nil].
	(class ~~ nil and: [classIsMeta]) ifTrue: [class := class class].

	(class == nil or: [class format ~= classFormat or: [class allInstVarNames asSet ~= classInstVarNames asSet]]) ifTrue: [
		newMetaclass := Metaclass new.
		newMetaclass hash.
		newMetaclass setSuperclass: Object class.
		newMetaclass setInstanceFormat: (classIsMeta ifTrue: [classFormat] ifFalse: [Object class format]).
		newMetaclass instanceVariables: (classIsMeta ifTrue: [(classInstVarNames asSet - Object class instVarNames asSet) asArray] ifFalse: [#()]).
		newMetaclass methodDictionary: Kernel.MethodDictionary new.

		class := newMetaclass new.
		class hash.
		class setName: className.
		class setSuperclass: Object.
		class setInstanceFormat: (classIsMeta ifTrue: [Object format] ifFalse: [classFormat]).
		class instanceVariables: (classIsMeta ifTrue: [#()] ifFalse: [classInstVarNames]).
		class methodDictionary: Kernel.MethodDictionary new.

		classIsMeta ifFalse: [
			classInstVarNames do: [:instVarName |  | methodNode |
				methodNode := class compilerClass new compile: instVarName, ' ^', instVarName in: class notifying: nil ifFail: [].
				class methodDictionary at: methodNode selector put: methodNode generate.
				methodNode := class compilerClass new compile: instVarName, ': anObject ', instVarName, ' := anObject' in: class notifying: nil ifFail: [].
				class methodDictionary at: methodNode selector put: methodNode generate].
			class flushVMmethodCache].
		classIsMeta ifTrue: [class := newMetaclass]].
	^class
!

version
	^version
! !

!ObjectMarshaler methodsFor:'reading - complex'!

get: reading binding: aClass
	<reads: 'Core.VariableBinding'>

	| isInStandardEnvironment |

	isInStandardEnvironment := self unmarshal: reading.
	isInStandardEnvironment
		ifTrue: [^(self get: reading string: String) asStrictReference binding].

	^(aClass
		key: (self get: reading symbol: Symbol)
		value: (self unmarshal: reading))
			environment: (self unmarshal: reading);
			yourself
!

get: reading bytes: aClass
	<reads: 'Core.ByteArray'>

	| size bytearray |
	size := self get: reading integer: nil.
	bytearray := ByteArray new: size.
	1 to: size do: [:each | bytearray at: each put: (self get: reading byte: nil)].
	^bytearray
!

get: reading class: aClass
	<reads: 'Core.Behavior'>

	| class |
	self get: reading class_id: [:id :behavior | class := behavior].
	^class
!

get: reading class_id: aBlock
	| id class className classIsMeta classFormat classInstVarSize classInstVarNames |
	id := self get: reading integer: nil.
	id > classes size ifFalse: [^aBlock value: id value: (classes at: id)].
	className := self get: reading string: String "asStrictReference value".
	classIsMeta := self unmarshal: reading.
	classFormat := self get: reading integer: Integer.
	classInstVarSize := self get: reading integer: Integer.
	classInstVarNames := (1 to: classInstVarSize) collect: [:each | self get: reading string: String].
	classesMutex critical: [
		class := self resolveClass: className isMeta: classIsMeta format: classFormat instVarNames: classInstVarNames.
		self includeClass: class].
	^aBlock value: id value: class
!

get: reading collection: aClass
	<reads: 'Core.Collection'>
	<reads: 'Core.OrderedCollection'>
	<reads: 'Core.Array'>

	| collection size |
	size := self get: reading integer: nil.
	collection := aClass withSize: size.
	1 to: size do: [:index | collection at: index put: (self unmarshal: reading)].
	^collection
!

get: reading compiledcode: aClass
	<reads: 'Kernel.CompiledCode'>

	| object variableSize |
	aClass isVariable
		ifTrue:
			[variableSize := self get: reading integer: nil.
			object := aClass basicNew: variableSize]
		ifFalse:
			[variableSize := 0.
			object := aClass basicNew].

	1 to: aClass instSize do: [:index | object instVarAt: index put: (self unmarshal: reading)].
	1 to: variableSize do: [:index | object basicAt: index put: (self unmarshal: reading)].
	^object
!

get: reading dictionary: aClass
	<reads: 'Core.Dictionary'>
	<reads: 'Core.KeyedCollection'>

	| size dictionary |
	size := self get: reading integer: nil.
	dictionary := aClass new.
	size timesRepeat: [dictionary at: (self unmarshal: reading) put: (self unmarshal: reading)].
	^dictionary
!

get: reading interval: aClass
	<reads: 'Core.Interval'>

	| start stop step |
	start := self unmarshal: reading.
	stop := self unmarshal: reading.
	step := self unmarshal: reading.
	^Interval from: start to: stop by: step
!

get: reading linkedlist: aClass
	<reads: 'Core.LinkedList'>

	| collection size |
	size := self get: reading integer: nil.
	collection := aClass new.
	1 to: size do: [:index | collection add: (self unmarshal: reading)].
	^collection
!

get: reading namespace: aClass
	<reads: 'Kernel.NameSpace'>

	^(self get: reading string: String) asStrictReference value
!

get: reading object: aClass
	<reads: 'Core.Object'>

	| object variableSize |
	aClass isVariable
		ifTrue:
			[variableSize := self get: reading integer: nil.
			object := aClass withSize: variableSize]
		ifFalse:
			[variableSize := 0.
			object := aClass basicNew].

	1 to: aClass instSize do: [:index | object instVarAt: index put: (self unmarshal: reading)].
	1 to: variableSize do: [:index | object basicAt: index put: (self unmarshal: reading)].
	^object
!

get: reading point: aClass
	<reads: 'Core.Point'>

	^Point
		x: (self unmarshal: reading) 
		y: (self unmarshal: reading)
!

get: reading set: aClass
	<reads: 'Core.Set'>

	| set size |
	size := self get: reading integer: nil.
	set := aClass new: size.
	size timesRepeat: [set add: (self unmarshal: reading)].
	^set
!

get: reading sortedCollection: aClass
	<reads: 'Core.SortedCollection'>

	| collection size sortBlock |
	size := self get: reading integer: nil.
	sortBlock := self unmarshal: reading.
	collection := Array new: size.
	1 to: size do: [:index | collection at: index put: (self unmarshal: reading)].
	^SortedCollection withAll: collection sortBlock: sortBlock
!

get: reading string: aClass
	<reads: 'Core.String'>
	<reads: 'Core.ByteString'>
	<reads: 'Core.TwoByteString'>
	<reads: 'Core.FourByteString'>

	| size string |
	size := self get: reading integer: nil.
	string := aClass new: size.
	1 to: size do: [:each | string at: each put: (self get: reading character: nil)].
	^string
!

get: reading symbol: aClass
	<reads: 'Core.Symbol'>
	<reads: 'Core.ByteSymbol'>
	<reads: 'Core.TwoByteSymbol'>
	<reads: 'Core.FourByteSymbol'>

	^(self get: reading string: String) asSymbol
!

get: reading variablePool: aClass
	<reads: 'Tools.WorkspaceVariablePool'>

	^aClass new
		imports: (self get: reading string: String);
		instVarNamed: 'bindings' put: (self unmarshal: reading);
		yourself
! !

!ObjectMarshaler methodsFor:'reading - core'!

get: reading byte: aClass
	^reading uint8 get
!

get: reading character: aClass
	<reads: 'Core.Character'>

	^Character codePoint: (self get: reading integer: nil)
!

get: writing false: boolean
	<reads: 'Core.False'>

	^false
!

get: writing nil: undefined
	<reads: 'Core.UndefinedObject'>

	^nil
!

get: writing true: boolean
	<reads: 'Core.True'>

	^true
! !

!ObjectMarshaler methodsFor:'reading - numbers'!

get: reading double: aClass
	<reads: 'Core.Double'>

	^reading double get
!

get: reading float: aClass
	<reads: 'Core.Float'>

	^reading float get
!

get: reading integer: aClass
	<reads: 'Core.Integer'>
	<reads: 'Core.SmallInteger'>
	<reads: 'Core.LargePositiveInteger'>
	<reads: 'Core.LargeNegativeInteger'>

	| indicator |
	indicator := self get: reading byte: nil.
	indicator < 252 ifTrue: [^indicator].
	indicator = 252 ifTrue: [^self get: reading integerSmall: aClass].
	indicator = 253 ifTrue: [^self get: reading integerMedium: aClass].
	indicator = 254 ifTrue: [^self get: reading integerLarge: aClass].
	indicator = 255 ifTrue: [^(self get: reading integerLarge: aClass) negated]
!

get: reading integerLarge: integer
	| printed |
	printed := self get: reading string: String.
	^Number readIntegerFrom: printed readStream radix: 36
!

get: reading integerMedium: aClass
	^reading int64 get
!

get: reading integerSmall: aClass
	^reading int32 get
! !

!ObjectMarshaler methodsFor:'writing - complex'!

put: writing binding: aBinding
	<writes: 'Core.VariableBinding'>

	self marshal: writing object: aBinding environment isInStandardEnvironment.
	aBinding environment isInStandardEnvironment
		ifTrue: [^self put: writing string: aBinding absoluteName].

	self put: writing string: aBinding key.
	self marshal: writing object: aBinding value.
	self marshal: writing object: aBinding environment.
!

put: writing bytes: bytearray
	<writes: 'Core.ByteArray'>

	self put: writing integer: bytearray size.
	bytearray do: [:byte | self put: writing byte: byte]
!

put: writing class: class
	<writes: 'Core.Behavior'>

	| id behavior |
	classesMutex critical: [
		(id := classes indexOf: class) isZero ifFalse: [self put: writing integer: id. ^id].
		id := self includeClass: class].
	self put: writing integer: id.
	behavior := class.
	class isMeta ifTrue: [behavior := behavior soleInstance].
	self put: writing string: behavior absoluteName.
	self marshal: writing object: class isMeta.
	self put: writing integer: class format.
	self put: writing integer: class instSize.
	class allInstVarNames do: [:each | self put: writing string: each].
	^id
!

put: writing collection: collection
	<writes: 'Core.Collection'>
	<writes: 'Core.OrderedCollection'>
	<writes: 'Core.Array'>

	self put: writing integer: collection size.
	collection do: [:object | self marshal: writing object: object]
!

put: writing compiledcode: aCompiledCode
	<writes: 'Kernel.CompiledCode'>

	self put: writing object: aCompiledCode
!

put: writing dictionary: dictionary
	<writes: 'Core.Dictionary'>
	<writes: 'Core.KeyedCollection'>

	self put: writing integer: dictionary size.
	dictionary keysAndValuesDo: [:key :value |
		self marshal: writing object: key.
		self marshal: writing object: value]
!

put: writing interval: interval
	<writes: 'Core.Interval'>

	self marshal: writing object: interval first.
	self marshal: writing object: interval last.
	self marshal: writing object: interval increment
!

put: writing linkedlist: aLinkedList
	<writes: 'Core.LinkedList'>

	self put: writing integer: aLinkedList size.
	aLinkedList do: [:object | self marshal: writing object: object]
!

put: writing namespace: aNamespace
	<writes: 'Kernel.NameSpace'>

	self put: writing string: aNamespace absoluteName
!

put: writing object: object
	<writes: 'Core.Object'>

	object class isVariable ifTrue: [self put: writing integer: object basicSize].
	1 to: object class instSize do: [:index | self marshal: writing object: (object instVarAt: index)].
	1 to: object basicSize do: [:index | self marshal: writing object: (object basicAt: index)]
!

put: writing point: point
	<writes: 'Core.Point'>

	self marshal: writing object: point x.
	self marshal: writing object: point y
!

put: writing set: set
	<writes: 'Core.Set'>

	self put: writing integer: set size.
	set do: [:object | self marshal: writing object: object]
!

put: writing sortedCollection: collection
	<writes: 'Core.SortedCollection'>

	self put: writing integer: collection size.
	self marshal: writing object: collection sortBlock.
	collection do: [:object | self marshal: writing object: object]
!

put: writing string: string
	<writes: 'Core.String'>
	<writes: 'Core.ByteString'>
	<writes: 'Core.TwoByteString'>
	<writes: 'Core.FourByteString'>
	<writes: 'Core.ByteSymbol'>
	<writes: 'Core.TwoByteSymbol'>
	<writes: 'Core.FourByteSymbol'>


	self put: writing integer: string size.
	string do: [:character | self put: writing character: character]
!

put: writing variablePool: aPool
	<writes: 'Tools.WorkspaceVariablePool'>

	self put: writing string: aPool importString.
	self marshal: writing object: aPool localBindings
! !

!ObjectMarshaler methodsFor:'writing - core'!

put: writing builtins: builtin
	<writes: 'Core.True'>
	<writes: 'Core.False'>
	<writes: 'Core.UndefinedObject'>
!

put: writing byte: byte
	writing uint8 put: byte
!

put: writing character: character
	<writes: 'Core.Character'>

	self put: writing integer: character codePoint
! !

!ObjectMarshaler methodsFor:'writing - numbers'!

put: writing double: double
	<writes: 'Core.Double'>

	writing double put: double
!

put: writing float: float
	<writes: 'Core.Float'>

	writing float put: float
!

put: writing integer: integer
	<writes: 'Core.Integer'>
	<writes: 'Core.SmallInteger'>
	<writes: 'Core.LargePositiveInteger'>
	<writes: 'Core.LargeNegativeInteger'>

	(integer between: 0 and: 251) ifTrue: [^self put: writing byte: integer].
	(integer between: -2147483647 and: 2147483648) ifTrue: [^self put: writing integerSmall: integer].
	(integer between: -9223372036854775807 and: 9223372036854775808) ifTrue: [^self put: writing integerMedium: integer].
	integer positive
		ifTrue:	[self put: writing integerPositiveLarge: integer]
		ifFalse:	[self put: writing integerNegativeLarge: integer]
!

put: writing integerLarge: integer
	| printed |
	printed := String new writeStream.
	integer printOn: printed base: 36.
	printed := printed contents.
	printed size > 9223372036854775808 ifTrue: [self error: 'this number is too big for me, try again in a thousand years.'].
	self put: writing string: printed
!

put: writing integerMedium: integer
	self put: writing byte: 253.
	writing int64 put: integer
!

put: writing integerNegativeLarge: integer
	self put: writing byte: 255.
	self put: writing integerLarge: integer negated
!

put: writing integerPositiveLarge: integer
	self put: writing byte: 254.
	self put: writing integerLarge: integer
!

put: writing integerSmall: integer
	self put: writing byte: 252.
	writing int32 put: integer
! !

!ObjectMarshaler class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ObjectMarshaler.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#TransformReadStream
	instanceVariableNames:'buffer bufferWriting sourceAtEnd block closeBlock'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

TransformReadStream comment:'Transform read stream provides the most expressive form of transformation. The transformation is described by a binary block that is given two arguments, @input and @output. Both @input and @output are streams themselves. The block can read arbitrary amount of elements from @input (including none) and write arbitrary amount of elements into @output (including none).The block will be invoked as many times as necessary to produce the required number of elements, or until an Incomplete is raised. Consequently if the block handles Incomplete from the input, it has to raise another Incomplete at some point, otherwise the stream will never end.

	Note that if the contentSpecies of the source doesn''t fit the output of the transformation, the #contentsSpecies of the transform stream has to be set explicitly. The #contentSpecies determines the type of collection employed by the internal buffer that is used as the storage for the virtual output stream of the transformation block. In some cases it might be desirable to tweak the buffering strategy of the virtual output stream. In that case the buffer of the stream can be set manually to any kind of Buffer that matches the requirements of the transformation.
	The closing behavior of the stream can be customized through the closeBlock. The default closeBlock simply propagates #close to the source as with any other transform stream.

Instance Variables
	buffer	<Buffer> holds the contents of the virtual ouput stream
	bufferWriting	<BufferWriteStream> the virtual output stream that is passed to the transformation block as the second argument
	sourceAtEnd	<Boolean> flag indicating that the source has signalled an Incomplete
	block	<BlockClosure> binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
	closeBlock	<BlockClosure> binary block invoked in response to the #close message, allows customizing the close behavior

'
!


!TransformReadStream class methodsFor:'instance creation'!

on: aReadStream block: block
	^self new on: aReadStream block: block
! !

!TransformReadStream methodsFor:'accessing'!

block
	^block
!

buffer
	^buffer
!

closeBlock
	^closeBlock
!

get
	(self fillBufferIfRequired: 1) ifFalse: [Incomplete zero raise].
	^buffer get
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count read |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[(self fillBufferIfRequired: anInteger - count) ifFalse: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		read := (anInteger - count) min: buffer readSize.
		buffer read: read into: aSequenceableCollection at: startIndex + count.
		count := count + read].
	^anInteger
! !

!TransformReadStream methodsFor:'initialize-release'!

buffer: aBuffer
	buffer recycle.
	buffer := aBuffer.
	bufferWriting := buffer writing
!

close
	buffer ifNil: [^self].
	sourceAtEnd := true.
	closeBlock cull: source cull: self.
	buffer recycle.
	buffer := nil
!

closeBlock: anObject
	closeBlock := anObject
!

contentsSpecies
	^buffer contentsSpecies
!

contentsSpecies: aClass

	self buffer: (buffer class new: buffer cacheSize class: aClass)
!

on: aReadStream block: aBlock
	
	self on: aReadStream.
	block := aBlock.
	closeBlock := [ :sourceStream | sourceStream close].
	sourceAtEnd := false.
	buffer := ElasticBuffer new: DefaultBufferSize class: aReadStream contentsSpecies.
	bufferWriting := buffer writing
! !

!TransformReadStream methodsFor:'printing'!

streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		space;
		write: '#';
		write: block method homeMethod selector;
		write: ' buffered: ';
		print: buffer readSize.
	buffer readSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsFuture
! !

!TransformReadStream methodsFor:'private'!

fillBuffer: anInteger
"
	We have exhausted our buffer, so fill it up again from our inner stream. Do not read more than is available from the inner stream or more than was originally requested. But try to be as greedy as possible, since filling our buffer is faster than always re-filling our buffer with one object at a time. Also, cap it at @bufferSize, because if we're reading from in-memory or on-disk sources, all the data will be immediately available - which could be gigs worth. We don't want to pull all of that in to our buffer.
	The semantics of our block are interesting. We give it both an input and an output stream. The block must write something to the output stream otherwise we assume this means we're at the end of the stream. It does not need to read from the input stream, but if it does and that stream fires EndOfStream, that also marks us as end of stream.
"
	| count available |
	count := 0.
	[[available := buffer readSize.
	block value: source value: bufferWriting.
	count := count + (buffer readSize - available).
	count >= anInteger ifTrue: [^self].
	buffer hasSpaceToWrite ifFalse: [^self]]
		repeat]
			on: Incomplete do: [:ex | ^sourceAtEnd := true].
!

fillBufferIfRequired: anInteger
"
	If we have any data available in our buffer, return true. If not, attempt to fill up our buffer and return true if that worked. Try not to fill the buffer more than was originally requested (@anInteger), but we make sure we only fill up to what's available from our inner stream. We don't guarantee we'll fill our buffer up to @anInteger's worth, just that we'll attempt to fill the buffer.
"
	buffer ifNil: [^false].
	buffer hasDataToRead ifTrue: [^true].
	sourceAtEnd ifTrue: [^false].
	self fillBuffer: anInteger.
	^buffer hasDataToRead
! !

!TransformReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__TransformReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#CollectWriteStream
	instanceVariableNames:'block cache'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

CollectWriteStream comment:'Converts written elements using the provided conversion block. Optimizes bulk writes by batching the conversion results, allowing the destination stream to perform bulk writes as well.

Instance Variables
	block	<BlockClosure> collecting block (same style as collect: blocks)
	cache	<SequenceableCollection> caches results after transformation so that they can be bulk written too

'
!


!CollectWriteStream class methodsFor:'instance creation'!

on: aWriteStream block: block
	^self new on: aWriteStream block: block
! !

!CollectWriteStream methodsFor:'accessing'!

block
	^block
!

insert: anInteger from: aSequenceableCollection at: startIndex
	| count amount written offset |
	count := 0.
	offset := startIndex.
	[count < anInteger] whileTrue:
		[amount := anInteger min: cache size.
		1 to: amount do: [:index | cache at: index put: (block value: (aSequenceableCollection at: offset+index))].
		written := [destination insert: anInteger from: cache. amount] on: Incomplete do: [ :ex | ex count ].
		count := count + written.
		written < amount ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		offset := offset + amount ].
	^anInteger
!

put: anObject
	destination put: (block value: anObject).
	^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count amount written offset |
	count := 0.
	offset := startIndex - 1.
	[count < anInteger] whileTrue:
		[amount := anInteger - count min: cache size.
		1 to: amount do: [:index | cache at: index put: (block value: (aSequenceableCollection at: offset + index))].
		written := [destination write: amount from: cache. amount] on: Incomplete do: [ :ex | ex count ].
		count := count + written.
		written < amount ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		offset := offset + amount ].
	^anInteger
! !

!CollectWriteStream methodsFor:'initialize-release'!

close
	super close.
	cache recycle.
	cache := nil
!

contentsSpecies

	^cache species
!

contentsSpecies: aClass

	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycled: (
				(cache notNil and: [ cache size > 0 ])
					ifTrue: [cache size]
					ifFalse: [DefaultBufferSize])
!

on: aDestination block: aBlock
	self on: aDestination.
	block := aBlock.
	self contentsSpecies: aDestination contentsSpecies
! !

!CollectWriteStream methodsFor:'seeking'!

++ anInteger
	^destination ++ anInteger
!

-- anInteger
	^destination -- anInteger
!

length
	^destination length
!

position
	^destination position
!

position: anInteger
	^destination position: anInteger
! !

!CollectWriteStream methodsFor:'testing'!

isPositionable
	^destination isPositionable
! !

!CollectWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__CollectWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#CollectReadStream
	instanceVariableNames:'block cache contentsSpecies direct'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

CollectReadStream comment:'Converts elements being read using the provided conversion block. When the contentSpecies of the source doesn''t match the desired contentSpecies of this stream, we optimize bulk reads by reading into an internal buffer.

Instance Variables
	block	<BlockClosure> collecting block (same style as collect: blocks)
	cache	<SequenceableCollection | nil> caches elements before transformation when direct is false
	contentsSpecies	<Class> species for collections of elements of this stream
	direct	<Boolean> are we using an intermediate buffer (when source''s contentSpecies doesn''t match ours)

'
!


!CollectReadStream class methodsFor:'instance creation'!

on: aReadStream block: block
	^self new on: aReadStream block: block
! !

!CollectReadStream methodsFor:'accessing'!

block
	^block
!

get
	^block value: source get
!

read: anInteger into: aSequenceableCollection at: startIndex
	direct
		ifTrue:	[self directRead: anInteger into: aSequenceableCollection at: startIndex]
		ifFalse:	[self bufferRead: anInteger into: aSequenceableCollection at: startIndex].
	^anInteger
! !

!CollectReadStream methodsFor:'initialize-release'!

close
	super close.
	cache ifNotNil: [ cache recycle ]
!

contentsSpecies
	^contentsSpecies
!

contentsSpecies: aClass
	contentsSpecies := aClass.
	cache ifNotNil: [ cache recycle ].
	cache := (direct := contentsSpecies == source contentsSpecies)
		ifTrue:	[nil]
		ifFalse:	[
			source contentsSpecies newRecycled: (
				(cache notNil and: [ cache size > 0 ])
					ifTrue: [cache size]
					ifFalse: [DefaultBufferSize])]
!

on: aSource block: aBlock
	self on: aSource.
	block := aBlock.
	contentsSpecies := aSource contentsSpecies.
	direct := true
! !

!CollectReadStream methodsFor:'private'!

bufferRead: anInteger into: aSequenceableCollection at: startIndex
	| amount count read |
	count := 0.
	[count < anInteger] whileTrue:
		[amount := (anInteger - count) min: cache size.
		read := [source read: amount into: cache at: 1. amount] on: Incomplete do: [ :ex | ex count ].
		1 to: read do: [:index | aSequenceableCollection at: count + startIndex + index - 1 put: (block value: (cache at: index))].
		count := count + read.
		read < amount ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise]]
!

directRead: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := [source read: anInteger into: aSequenceableCollection at: startIndex. anInteger] on: Incomplete do: [ :ex | ex count ].
	startIndex to: startIndex + count - 1 do: [:index | aSequenceableCollection at: index put: (block value: (aSequenceableCollection at: index))].
	count < anInteger ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise]
! !

!CollectReadStream methodsFor:'seeking'!

++ anInteger
	^source ++ anInteger
!

-- anInteger
	^source -- anInteger
!

length
	^source length
!

position
	^source position
!

position: anInteger
	^source position: anInteger
! !

!CollectReadStream methodsFor:'testing'!

isPositionable
	^source isPositionable
! !

!CollectReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__CollectReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#DuplicateReadStream
	instanceVariableNames:'duplicate'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

DuplicateReadStream comment:'Duplicates contents flowing through the stream into a secondary write stream.

Instance Variables
	duplicate	<WriteStream> stream to duplicate the content to

'
!


!DuplicateReadStream class methodsFor:'instance creation'!

on: aSource duplicate: aDestination

	^self new on: aSource duplicate: aDestination
! !

!DuplicateReadStream methodsFor:'accessing'!

read: anInteger into: aSequenceableCollection at: startIndex

	[	source read: anInteger into: aSequenceableCollection at: startIndex.
	] on: Incomplete do: [ :incomplete |
		duplicate write: incomplete count from: aSequenceableCollection at: startIndex.
		incomplete pass ].
	duplicate write: anInteger from: aSequenceableCollection at: startIndex
! !

!DuplicateReadStream methodsFor:'initialize-release'!

contentsSpecies

	^source contentsSpecies
!

on: aSource duplicate: aDestination

	super on: aSource.
	duplicate := aDestination
! !

!DuplicateReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__DuplicateReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

LibraryDefinition subclass:#stx_goodies_xtreams_transforms
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

stx_goodies_xtreams_transforms comment:'Transforms are streams on top of other streams. A stack of transforms on top of each other with a terminal stream at the bottom is called a *stream stack*. The usual purpose of a transform stream is transformation of the elements that are passing through it. Alternative it can be some sort of a side-effect while passing the elements through unchanged, e.g. counting, logging, hashing. A transform may also cause the number of elements to change, e.g. compression, encoding, filtering, etc.


        == Collection enumeration analogs ==

Following set of transforms emulates the popular collection enumerators, providing the same sort of benefits. Primary difference is that the enumeration happens incrementally, as elements are being written into or read from the stream. This avoids some of the overhead that the collection API incurs improving scalability of these operations on large datasets.


        === Element Conversion (#collecting:) ===

This is the simplest form of transformation where elements are transformed one for one, i.e. the number of elements before and after transformation is the same.
{{{
        "squaring read input"
        ((1 to: 10) reading collecting: [ :e | e * e ]) rest
}}}
{{{
        "normalizing output"
        (String new writing collecting: #asLowercase) write: ''abcABC''; conclusion
}}}


        === Element Filtering (#selecting:/#rejecting:) ===

These transformations eliminate some of the elements flowing through the stream based on provided criteria. The number of elements after the transformation is same or smaller than before transformation.
{{{
        ((1 to: 50) reading selecting: [ :e | e odd ]) rest
}}}
{{{
        (String new writing rejecting: [ :c | c isLowercase ]) write: ''abABcC''; conclusion
}}}


        === Additional Processing of Elements (#doing:) ===

The #doing: transformation allows to perform additional activity with each element flowing through the stream. The elements can be counted, logged, copied into a different stream, etc.
{{{
        count := 0.
        (''abcdef'' reading doing: [ :e | count := count + 1 ]) rest.
        count
}}}
{{{
        log := String new writing.
        (String new writing doing: [ :e | log put: e ]) write: ''abcdef''.
        log conclusion
}}}


        === Per-Element Accumulation (#injecting:into:) ===

The #inject:into: idiom is used to simplify the expression of a running value computed over a set of elements. In the streaming variant the resulting stream provides the subsequent states of the running value (not the elements). 

{{{
        "e series"
        x := 1.
        integers := [ x := x + 1 ] reading.
        ((integers injecting: 1 into: [ :sum :next | sum + next factorial reciprocal ]) collecting: #asDouble) read: 20
}}}
{{{
        (Array new writing injecting: 0 into: [ :total :each | each + total ]) write: (1 to: 10); conclusion
}}}


        == Specialized Transformations ==

These are specific, commonly used transformations. They are often optimized via a dedicated stream class, but that is usually hidden behind the conventional creation methods on ReadStream.


        === Character encoding (#encoding:) ===

Character encoding is a process of turning a sequence of characters into a sequence of bytes. The inverse process is called decoding. There are different kinds of character encoding often tailored to specific alphabets. Some are able to encode only a certain subset of characters, others are able to encode any character. These specific kinds of encodings are usually identified with their names, e.g. ''ASCII'', ''UTF-8'', ''ISO 8859-1''. When creating an encoding stream, the encoding name has to be specified. Any encoding name recognized by class Encoder can be used.
{{{
        (ByteArray new writing encoding: #iso8859_1) write: ''Hello''; conclusion
}}}
Encoding write stream consumes characters and converts them into bytes. Consequently the underlying write stream must be binary (i.e accept bytes (0..255)).
The encoding stream also performs automatic conversion of CRs (Character cr) into the native line-end convention of the underlying platform, unless set into a different line-end convention mode.
{{{
        (ByteArray new writing encoding: #utf16)
                setLineEndCRLF;
                write: ''Hello World!!\Bye World!!'' withCRs;
                conclusion
}}}
An encoding read stream reads bytes from an underlying binary stream, decodes the bytes according to the pre-configured encoding and produces characters. It also performs automatic line end conversion from arbitrary platform convention to CRs, unless set into a transparent mode.
{{{
        (#[65 66 67 13 10 68 69 70 10 71 72 73 ] reading encoding: #ascii) rest
        (#[65 66 67 13 10 68 69 70 10 71 72 73 ] reading encoding: #ascii) setLineEndTransparent; rest
}}}


        === Base-64 encoding (#encodingBase64) ===

Base-64 encoding is a commonly used encoding of bytes into characters, usually for the purpose of transporting bytes over text based protocols (e.g. MIME or XML). This is different from character encoding, the input and output type is inverted. The encoding has to be able to handle arbitrary sequence of bytes, but not every character sequence is valid base-64 encoding.
Consequently the write stream consumes bytes and writes characters into the underlying stream. Note that base-64 encoding requires specific treatment at the end of the encoding sequence, so base-64 write stream must be closed at the end.
{{{
        encoded := String new.
        encoded writing encodingBase64 write: (ByteArray withAll: (0 to: 255)); close.
        encoded
}}}
The read stream reads characters from underlying stream and converts the characters into bytes.
{{{
        encoded reading encodingBase64 rest
}}}
The read stream ignores any intervening white space that might be used to format the base-64 characters for transport (e.g. base-64 encoding is often wrapped to certain line length with new-line characters interspersed with the base-64 characters. The read stream will automatically end when it encounters the base-64 termination sequence ($=). Note however that the sequence is not always present, so it cannot be used as a reliable stream terminator.


        == General Transformations (#transforming:) ==

This is the most general form of transformation. The block argument receives two streams, input and output. The block can read arbitrary number of elements from input (including none) and write arbitrary number of elements into the output (including none).

With read streams the input is the underlying source stream and output is a virtual stream of elements to be produced by the stream. The block will be invoked as many times as necessary to produce the requested number of elements (requested by a read call), or until an Incomplete is raised. Consequently if the block handles Incomplete from the input, it has to raise an Incomplete at some point, otherwise the stream will never end (improper Incomplete handling can result in tight infinite loops).
{{{
        "Multiply each pair of input elements together and return the result"
        ((Array withAll: (1 to: 20)) reading transforming: [ :in :out | out put: in get * in get ]) rest
}}}
Note that if the contentSpecies of the source doesn''t fit the output of the transformation, the contentsSpecies of the transform stream has to be set explicitly.
{{{
        "hex encoding: #[0 1 2 ... 255] -> ''000102...FF'' "
        bytes := ByteArray withAll: (0 to: 255).
        digits := ''0123456789ABCDEF''.
        byte2hex := [ :in :out || byte |        
                byte := in get.
                out put: (digits at: (byte bitShift: -4) + 1).
                out put: (digits at: (byte bitAnd: 15) + 1) ].
        (bytes reading transforming: byte2hex)
                contentsSpecies: String;
                rest
}}}
In case of write streams, the input of the transform block is a virtual stream of written elements and the output is the underlying destination stream. The block will be invoked as many times as necessary to consume any written elements, or until an Incomplete is raised by the destination. Again depending on the specifics of the transformation the contentsSpecies may have to be set explicitly (the collection used by the buffer backing the virtual input stream must be able accommodate any written elements).
{{{
        (String new writing transforming: byte2hex)
                contentsSpecies: ByteArray;
                write: bytes;
                conclusion
}}}
Note that in order to allow writing transformation blocks for write streams the same way as for read streams, the write stream has to be backed up by a background process, which allows suspending the execution of the transformation block in case it needs to wait for more elements to be written. The benefit is that the same transformation block can be used on both read and write stream without change to perform the same transformation.


        == CType Import/Export (Interpreting) ==

Interpreting streams convert specific types of objects to/from bytes of corresponding primitive C-type, i.e. they assign designated "interpretation" to the bytes (terminology borrowed from UninterpretedBytes and associated suite of primitives employed by these streams). Supported C-types are defined by the Interpretations shared variable on class InterpretedBytes. The streams are created with message #interpreting: with argument being a Symbol denoting the C-type in the Interpretations registry, e.g. #float, #double, #unsignedChar, etc.

InterpretedWriteStream converts consumed elements into bytes of pre-configured (primitive) CType, e.g. float, long etc. The type of written elements must match the C-type and the underlying destination must be binary. InterpretReadStream performs the inverse transformation, converting bytes from a binary source according to the pre-configured (primitive) CType, e.g. float, long etc. It produces elements of corresponding class, e.g. #float -> Float, #double -> Double, etc.
{{{
        doubles := [ Random new next ] reading.
        bytes := (ByteArray new writing interpreting: #double)
                write: 10 from: doubles;
                conclusion.
        (bytes reading interpreting: #double) read: 10
}}}


        == Marshaling ==

Marshaling streams are used to encode arbitrary smalltalk objects into a sequence of bytes suitable for binary storage or transport. The format of the binary encoding is defined by an ObjectMarshaler and is identified by particular version ID. Custom marshalers can be derived from ObjectMarshaler. Custom marshaling formats must declare their own (unique) version ID.
{{{
        object := 5 @ 5 extent: 5 @ 5.
        bytes := ByteArray new writing marshaling put: object; conclusion.
        bytes reading marshaling get
}}}
'
!

!stx_goodies_xtreams_transforms class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 73 2012-01-30 22:30:43Z mkobetic $'
! !

!stx_goodies_xtreams_transforms class methodsFor:'description'!

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
        #'stx:goodies/xtreams/core'    "Xtreams::ReadStream - superclass of Xtreams::DuplicateReadStream "
        #'stx:goodies/xtreams/support'    "Xtreams::Encoder - superclass of Xtreams::ASCIIEncoder "
        #'stx:goodies/xtreams/terminals'    "Xtreams::BufferedWriteStream - referenced by Xtreams::WriteStream>>buffering: "
        #'stx:libbasic'    "ProjectDefinition - superclass of stx_goodies_xtreams_transforms "
        #'stx:libbasic2'    "IntegerArray - referenced by Xtreams::MessagePackMarshaler>>initializeMarshaling "
    )
! !

!stx_goodies_xtreams_transforms class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'Xtreams::ASCIIEncoder'
        #'Xtreams::CollectReadStream'
        #'Xtreams::CollectWriteStream'
        #'Xtreams::DuplicateReadStream'
        #'Xtreams::DuplicateWriteStream'
        #'Xtreams::EncodeReadStream'
        #'Xtreams::EncodeWriteStream'
        #'Xtreams::ISO8859L1Encoder'
        #'Xtreams::InterpretedReadStream'
        #'Xtreams::InterpretedWriteStream'
        #'Xtreams::MessagePackMarshaler'
        #'Xtreams::ObjectAnalyseStream'
        #'Xtreams::ObjectMarshaler'
        #'Xtreams::ObjectReadStream'
        #'Xtreams::ObjectWriteStream'
        #'Xtreams::TransformReadStream'
        #'Xtreams::TransformWriteStream'
        #'stx_goodies_xtreams_transforms'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        #'Xtreams::ReadStream' collecting:
        #'Xtreams::ReadStream' depairing
        #'Xtreams::ReadStream' doing:
        #'Xtreams::ReadStream' duplicating:
        #'Xtreams::ReadStream' encoding:
        #'Xtreams::ReadStream' encodingBase64
        #'Xtreams::ReadStream' encodingHex
        #'Xtreams::ReadStream' injecting:into:
        #'Xtreams::ReadStream' interpreting:
        #'Xtreams::ReadStream' interpreting:cacheSize:
        #'Xtreams::ReadStream' interpreting:size:
        #'Xtreams::ReadStream' interpreting:size:cacheSize:
        #'Xtreams::ReadStream' marshaling
        #'Xtreams::ReadStream' marshaling:
        #'Xtreams::ReadStream' monitoring:every:
        #'Xtreams::ReadStream' next
        #'Xtreams::ReadStream' pairing
        #'Xtreams::ReadStream' rejecting:
        #'Xtreams::ReadStream' selecting:
        #'Xtreams::ReadStream' transforming:
        #'Xtreams::WriteStream' collecting:
        #'Xtreams::WriteStream' depairing
        #'Xtreams::WriteStream' doing:
        #'Xtreams::WriteStream' duplicating:
        #'Xtreams::WriteStream' encoding:
        #'Xtreams::WriteStream' encodingBase64
        #'Xtreams::WriteStream' encodingHex
        #'Xtreams::WriteStream' injecting:into:
        #'Xtreams::WriteStream' interpreting:
        #'Xtreams::WriteStream' interpreting:cacheSize:
        #'Xtreams::WriteStream' interpreting:size:
        #'Xtreams::WriteStream' interpreting:size:cacheSize:
        #'Xtreams::WriteStream' marshaling
        #'Xtreams::WriteStream' marshaling:
        #'Xtreams::WriteStream' monitoring:every:
        #'Xtreams::WriteStream' nextPut:
        #'Xtreams::WriteStream' nextPutAll:
        #'Xtreams::WriteStream' pairing
        #'Xtreams::WriteStream' rejecting:
        #'Xtreams::WriteStream' selecting:
        #'Xtreams::WriteStream' transforming:
        #'Xtreams::ReadStream' positioning
        #'Xtreams::WriteStream' buffering:
        #'Xtreams::WriteStream' positioning
    )
! !

!stx_goodies_xtreams_transforms class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_transforms class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/transforms/stx_goodies_xtreams_transforms.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'74'"$"
! !

!stx_goodies_xtreams_transforms class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_transforms.st 19 2011-11-21 06:04:06Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

Encoder subclass:#ISO8859L1Encoder
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

ISO8859L1Encoder comment:'Implements ISO-8859-1 (Latin 1) encoding.

'
!


!ISO8859L1Encoder class methodsFor:'class initialization'!

initialize
	| newSelf |
	newSelf := self new.
	#(#'latin-1' #latin1 #iso8859L1 #ISO8859L1) do: [:id | self encoders at: id put: newSelf]
! !

!ISO8859L1Encoder methodsFor:'accessing'!

decodeFrom: aReadStream
	^Character value: aReadStream get
!

encode: aCharacter on: aWriteStream
	aWriteStream put: aCharacter asInteger
! !

!ISO8859L1Encoder class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ISO8859L1Encoder.st 73 2012-01-30 22:30:43Z mkobetic $'
! !

ISO8859L1Encoder initialize!
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#DuplicateWriteStream
	instanceVariableNames:'duplicate'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

DuplicateWriteStream comment:'Duplicates contents flowing through the stream into a secondary write stream.

Instance Variables
	duplicate	<WriteStream> stream to duplicate the content to

'
!


!DuplicateWriteStream class methodsFor:'instance creation'!

on: aDestination duplicate: aSecondDestination

	^self new on: aDestination duplicate: aSecondDestination
! !

!DuplicateWriteStream methodsFor:'accessing'!

write: anInteger from: aSequenceableCollection at: startIndex

	[	destination write: anInteger from: aSequenceableCollection at: startIndex
	] on: Incomplete do: [ :incomplete |
		duplicate write: incomplete count from: aSequenceableCollection at: startIndex.
		incomplete pass ].
	duplicate write: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
! !

!DuplicateWriteStream methodsFor:'initialize-release'!

contentsSpecies

	^destination contentsSpecies
!

on: aDestination duplicate: aSecondDestination

	super on: aDestination.
	duplicate := aSecondDestination
! !

!DuplicateWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__DuplicateWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

Object subclass:#MessagePackMarshaler
	instanceVariableNames:'unmarshaling marshaling analysing'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

MessagePackMarshaler comment:'MessagePackMarshaler defines the binary format of the MessagePack protocol ( http://wiki.msgpack.org/display/MSGPACK/Format+specification ), which is a binary JSON. It can marshal simple objects, but not whole classes, just like JSON. It is considered to be a very fast marshaler because of its lightweight protocol. It cannot handle circular references.

Instance Variables
	analysing	<Object>	analysing operations
	marshaling	<Dictionary>	marshaling operations
	unmarshaling	<(Array of: (BlockClosure))>	unmarshaling operations



'
!


!MessagePackMarshaler class methodsFor:'instance creation'!

new
	^super new initialize
! !

!MessagePackMarshaler class methodsFor:'constants - containers'!

array16
	^16rDC
!

array32
	^16rDD
!

map16
	^16rDE
!

map32
	^16rDF
!

raw16
	^16rDA
!

raw32
	^16rDB
! !

!MessagePackMarshaler class methodsFor:'constants - numbers'!

double
	^16rCB
!

float
	^16rCA
!

int16
	^16rD1
!

int32
	^16rD2
!

int64
	^16rD3
!

int8
	^16rD0
!

uint16
	^16rCD
!

uint32
	^16rCE
!

uint64
	^16rCF
!

uint8
	^16rCC
! !

!MessagePackMarshaler class methodsFor:'constants - singletons'!

false
	^16rC2
!

nil
	^16rC0
!

true
	^16rC3
! !

!MessagePackMarshaler methodsFor:'api'!

analyse: reading
	| type |
	type := reading uint8 get.
	type <= 16rBF ifTrue: [
		| fixMapOrArray |
		type <= 16r7F ifTrue: [^reading log: 'positive fixnum' do: [type]].
		fixMapOrArray := type bitShift: -4.
		fixMapOrArray = 2r1001 ifTrue: [^reading log: 'fix array' do: [(1 to: (type bitAnd: 2r00001111)) collect: [:i | self analyse: reading]]].
		fixMapOrArray = 2r1000 ifTrue: [
			^reading log: 'fix map' do: [
				| map |
				map := Dictionary new.
				(type bitAnd: 2r00001111) timesRepeat: [
					map at: (self analyse: reading) put: (self analyse: reading)].
				map]].
		^reading log: 'fix raw' do: [reading uint8 read: (type bitAnd: 2r00011111)]].
	(type bitShift: -5) = 2r111 ifTrue: [^reading log: 'negative fixnum' do: [-32 + (type bitAnd: 2r00011111)]].
	^reading log: (type printStringRadix: 16) do: [(analysing at: type) value: reading]
!

marshal: writing object: object
	(marshaling at: object class ifAbsent: [self error: 'Unmarshalable class with the MessagePack protocol']) value: writing value: object
!

unmarshal: reading
	| type |
	type := reading uint8 get.
	type <= 16rBF ifTrue: [
		| fixMapOrArray |
		type <= 16r7F ifTrue: [^type].
		fixMapOrArray := type bitShift: -4.
		fixMapOrArray = 2r1001 ifTrue: [^(1 to: (type bitAnd: 2r00001111)) collect: [:i | self unmarshal: reading]].
		fixMapOrArray = 2r1000 ifTrue: [
			| map |
			map := Dictionary new.
			(type bitAnd: 2r00001111) timesRepeat: [
				map at: (self unmarshal: reading) put: (self unmarshal: reading)].
			^map].
		^reading uint8 read: (type bitAnd: 2r00011111)].
	(type bitShift: -5) = 2r111 ifTrue: [^-32 + (type bitAnd: 2r00011111)].
	^(unmarshaling at: type) value: reading
! !

!MessagePackMarshaler methodsFor:'configuration'!

configureAnalyse: reading
	"This protocol has fixed endianness built in"
	^true
!

configureMarshal: writing
	"This protocol has fixed endianness built in"
	^true
!

configureUnmarshal: reading
	"This protocol has fixed endianness built in"
	^true
! !

!MessagePackMarshaler methodsFor:'initialize-release'!

initialize
	self initializeMarshaling.
	self initializeUnmarshaling.
	self initializeAnalysing.
!

initializeAnalysing
	(analysing := unmarshaling copy)
		at: self class array16 put: [:reading | reading log: 'array16' do: [(1 to: reading uint16 get) collect: [:i | self analyse: reading]]];
		at: self class array32 put: [:reading | reading log: 'array32' do: [(1 to: reading uint32 get) collect: [:i | self analyse: reading]]];
		at: self class map16 put: [:reading |
			reading log: 'map16' do: [
				| map |
				map := Dictionary new.
				reading uint16 get timesRepeat: [
					map at: (self analyse: reading) put: (self analyse:reading)].
				map]];
		at: self class map32 put: [:reading |
			reading log: 'map32' do: [
				| map |
				map := Dictionary new.
				reading uint16 get timesRepeat: [
					map at: (self analyse: reading) put: (self analyse: reading)].
				map]];
		yourself
!

initializeMarshaling
	(marshaling := Dictionary new)
		"singletons"
		at: UndefinedObject put: [:writing :object | writing uint8 put: self class nil];
		at: True put: [:writing :object | writing uint8 put: self class true];
		at: False put: [:writing :object | writing uint8 put: self class false];

		"numbers"
		at: Float put: [:writing :object | writing uint8 put: self class float. writing float put: object];
		at: Double put: [:writing :object | writing uint8 put: self class double. writing double put: object];
		at: SmallDouble put: [:writing :object | writing uint8 put: self class double. writing double put: object];
		yourself.

	Integer allSubclassesDo: [:each |
		marshaling at: each put: [:writing :object | self write: writing integer: object]].

	SequenceableCollection allSubclassesDo: [:each |
		marshaling at: each put: [:writing :object | self write: writing array: object]].
	(KeyedCollection withAllSubclasses, Dictionary withAllSubclasses) do: [:each |
		marshaling at: each put: [:writing :object | self write: writing map: object]].
	(CharacterArray withAllSubclasses, IntegerArray withAllSubclasses) do: [:each |
		marshaling at: each put: [:writing :object | self error: each name, ' are not supported by the MessagePack protocol']].
	marshaling at: ByteArray put: [:writing :object | self write: writing raw: object]
!

initializeUnmarshaling
	(unmarshaling := Array new: 255 withAll: [:reading | self error: 'unknown type'])
		"singletons"
		at: self class nil put: [:reading | nil];
		at: self class true put: [:reading | true];
		at: self class false put: [:reading | false];

		"numbers"
		at: self class uint8 put: [:reading | reading uint8 get];
		at: self class uint16 put: [:reading | reading uint16 get];
		at: self class uint32 put: [:reading | reading uint32 get];
		at: self class uint64 put: [:reading | reading uint64 get];
		at: self class int8 put: [:reading | reading int8 get];
		at: self class int16 put: [:reading | reading int16 get];
		at: self class int32 put: [:reading | reading int32 get];
		at: self class int64 put: [:reading | reading int64 get];
		at: self class float put: [:reading | reading float get];
		at: self class double put: [:reading | reading double get];

		"containers"
		at: self class raw16 put: [:reading | reading uint8 read: reading uint16 get];
		at: self class raw32 put: [:reading | reading uint8 read: reading uint32 get];
		at: self class array16 put: [:reading | (1 to: reading uint16 get) collect: [:i | self unmarshal: reading]];
		at: self class array32 put: [:reading | (1 to: reading uint32 get) collect: [:i | self unmarshal: reading]];
		at: self class map16 put: [:reading |
			| map |
			map := Dictionary new.
			reading uint16 get timesRepeat: [
				map at: (self unmarshal: reading) put: (self unmarshal: reading)].
			map];
		at: self class map32 put: [:reading |
			| map |
			map := Dictionary new.
			reading uint32 get timesRepeat: [
				map at: (self unmarshal: reading) put: (self unmarshal: reading)].
			map];
		yourself
! !

!MessagePackMarshaler methodsFor:'private - writing'!

write: writing array: array
	self write: writing array_size: array size.
	array do: [:each | self marshal: writing object: each]
!

write: writing array_size: size
	size <= 2r00001111 ifTrue: [^writing uint8 put: size + 2r10010000].
	size <= 65535 ifTrue: [
		writing uint8 put: self class array16.
		^writing uint16 put: size].
	size <= 4294967295 ifTrue: [
		writing uint8 put: self class array32.
		^writing uint32 put: size].
	self error: 'array too big to marshal with MessagePack protocol'
!

write: writing integer: integer
	(integer between: 0 and: 127) ifTrue: [^writing uint8 put: integer].
	(integer between: -32 and: -1) ifTrue: [^writing uint8 put: integer + 256].
	integer >= 128 ifTrue: [
		integer <= 255 ifTrue: [^writing uint8 put: self class uint8; put: integer].
		integer <= 65535 ifTrue: [
			writing uint8 put: self class uint16.
			^writing uint16 put: integer].
		integer <= 4294967295 ifTrue: [
			writing uint8 put: self class uint32.
			^writing uint32 put: integer].
		integer <= 18446744073709551615 ifTrue: [
			writing uint8 put: self class uint64.
			^writing uint64 put: integer].
		self error: 'integer too big to marshal with MessagePack protocol'].
	integer >= -128 ifTrue: [
		writing uint8 put: self class int8.
		^writing int8 put: integer].
	integer >= -32768 ifTrue: [
		writing uint8 put: self class int16.
		^writing int16 put: integer].
	integer >= -2147483648 ifTrue: [
		writing uint8 put: self class int32.
		^writing int32 put: integer].
	integer >= -9223372036854775808 ifTrue: [
		writing uint8 put: self class int64.
		^writing int64 put: integer].
	self error: 'integer too small to marshal with MessagePack protocol'.
!

write: writing map: map
	self write: writing map_size: map size.
	map keysAndValuesDo: [:key :value |
		self marshal: writing object: key.
		self marshal: writing object: value]
!

write: writing map_size: size
	size <= 2r00001111 ifTrue: [^writing uint8 put: size + 2r10000000].
	size <= 65535 ifTrue: [
		writing uint8 put: self class map16.
		^writing uint16 put: size].
	size <= 4294967295 ifTrue: [
		writing uint8 put: self class map32.
		^writing uint32 put: size].
	self error: 'array too big to marshal with MessagePack protocol'
!

write: writing raw: bytearray
	self write: writing raw_size: bytearray size.
	writing uint8 write: bytearray
!

write: writing raw_size: size
	size <= 2r00011111 ifTrue: [^writing uint8 put: size + 2r10100000].
	size <= 65535 ifTrue: [
		writing uint8 put: self class raw16.
		^writing uint16 put: size].
	size <= 4294967295 ifTrue: [
		writing uint8 put: self class raw32.
		^writing uint32 put: size].
	self error: 'array too big to marshal with MessagePack protocol'
! !

!MessagePackMarshaler class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__MessagePackMarshaler.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#EncodeReadStream
	instanceVariableNames:'transparent crPreceeding encoder buffer bufferWriting
		bufferReading'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

EncodeReadStream comment:'Converts bytes into characters using pre-configured encoding. At the same time, if set to lineEndAuto (default) it can perform line-end translation, converting any line-end convention into CRs. The source stream must provide bytes (0...255).

Instance Variables
	transparent	<Boolean> should the stream perform line-end translations
	crPreceeding	<Boolean> was previous character read a CR (used when not transparent)
	encoder	<Encoder> converts bytes to characters
	buffer	<Buffer on: ByteArray> used to optimize bulk reads
	bufferWriting	<WriteStream> write stream on buffer
	bufferReading	<ReadStream> read stream on buffer

'
!


!EncodeReadStream class methodsFor:'instance creation'!

on: aSource encoding: anEncoding
	^self new on: aSource encoding: anEncoding
! !

!EncodeReadStream methodsFor:'accessing'!

encoder

	^encoder
!

get
	| character |
	buffer hasDataToRead ifTrue: [^super get].
	character := encoder decodeFrom: source.
	transparent ifFalse: 
		[character == LF
			ifTrue: [crPreceeding
				ifTrue: 
					[character := encoder decodeFrom: source.
					crPreceeding := character = CR]
				ifFalse: 
					[crPreceeding := false.
					character := CR]]
			ifFalse: [crPreceeding := character = CR]].
	^character
!

read: anInteger into: aSequenceableCollection at: startIndex

	| remaining position character bufferAvailable |
	remaining := anInteger.
	position := startIndex.
	[remaining > 0] whileTrue: [
		| mark |
		"Top up our buffer if we have room and we need data"
		[bufferWriting write: (buffer writeSize min: remaining) from: source] on: Incomplete do: [:incomplete |
			(incomplete count == 0 and: [buffer hasDataToRead not]) ifTrue: [
				(Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].

		"We now conduct an inner loop that iterates over the buffer data while:
			a) we need to read more data
			b) there is data available in the buffer
			c) a character can successfully be decoded
		"

		"If our buffer size is too low before we begin our decode loop, we need to take an undo copy in case we cannot decode a character."
		buffer readSize < 10 ifTrue:
			[mark := buffer readPosition.
			encoder backupState ].

		[["The following may raise an incomplete, which means we don't have enough data in the buffer to decode the full character.
		 This is handled by the Incomplete exception capture before."
		character := encoder decodeFrom: bufferReading.

		"If we are not transparent, convert stray LFs in to CRs and CRLFs in to CRs"
		transparent ifFalse: [
			character == LF
				ifTrue:	[character := crPreceeding ifTrue: [nil] ifFalse: [CR]. crPreceeding := false]
				ifFalse:	[crPreceeding := character = CR]].

		"If we didn't filter out an LF at the tail of a CRLF, commit the character to the output."
		character == nil ifFalse:
			[aSequenceableCollection at: position put: character.
			remaining := remaining - 1.
			position := position + 1].

		"Find out how much data we have left in the buffer. If it's too low we need to keep track of the undo record in case we cannot decode a character."
		(bufferAvailable := buffer readSize) < 10 ifTrue:
			[mark := buffer readPosition.
			encoder backupState ].

		remaining > 0 and: [bufferAvailable > 0]] whileTrue]
			on: Incomplete do: [:incomplete |
				"We failed to decode a character, we've hit the end of the buffer and need to refill it. We rewind the buffer and leave the decoding loop
				 to return to the main loop where more data will be fetched in to our buffer."
				buffer readPosition: mark.
				encoder restoreState]].
	^anInteger
! !

!EncodeReadStream methodsFor:'initialize-release'!

close
	super close.
	buffer recycle.
	buffer := nil
!

contentsSpecies
        
        ^encoder contentsSpecies
!

on: aSource encoding: anEncoding

	super on: aSource.
	encoder := Encoder for: anEncoding.
	buffer := RingBuffer new: DefaultBufferSize class: ByteArray.
	bufferReading := buffer reading.
	bufferWriting := buffer writing.
	transparent := false.
	crPreceeding := false.
! !

!EncodeReadStream methodsFor:'line-end'!

setLineEndAuto

	transparent := false
!

setLineEndTransparent

	transparent := true
! !

!EncodeReadStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__EncodeReadStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

Encoder subclass:#ASCIIEncoder
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!

ASCIIEncoder comment:'Implements ASCII encoding.

'
!


!ASCIIEncoder class methodsFor:'class initialization'!

initialize

	self encoders
		at: #ascii put: self new;
		at: #ASCII put: self new
! !

!ASCIIEncoder methodsFor:'accessing'!

decodeFrom: aReadStream

	| value |
	^(value := aReadStream get) < 128
		ifTrue: [ Character value: value ]
		ifFalse: [ self error: 'Illegal value!!' ]
!

encode: aCharacter on: aWriteStream

	| value |
	(value := aCharacter asInteger) < 128
		ifTrue: [ aWriteStream put: value ]
		ifFalse: [ self error: 'Illegal character!!' ]
! !

!ASCIIEncoder class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ASCIIEncoder.st 73 2012-01-30 22:30:43Z mkobetic $'
! !

ASCIIEncoder initialize!
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#EncodeWriteStream
	instanceVariableNames:'encoder buffer bufferReading bufferWriting decodedLineEnd
		encodedLineEnd'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

EncodeWriteStream comment:'Accepts characters, converts them to bytes (0..255) using pre-configured encoding and writes the bytes into destination. Unless set to lineEndTransparent, converts any CRs into configured line-end convention (LF or CRLF).

Instance Variables
	encoder	<Encoder> converts characters to bytes
	buffer	<Buffer on: ByteArray> batch writing buffer
	bufferReading	<ReadStream> read stream on buffer
	bufferWriting	<WriteStream> write stream on buffer
	decodedLineEnd	<Character> CR or nil if transparent
	encodedLineEnd	<ByteArray> encoded bytes of CR in the configured convention (LF or CRLF), or nil if transparent

'
!


!EncodeWriteStream class methodsFor:'instance creation'!

on: aDestination encoding: anEncoding
	^self new on: aDestination encoding: anEncoding
! !

!EncodeWriteStream methodsFor:'accessing'!

encoder

	^encoder
!

write: anInteger from: aSequenceableCollection at: startIndex

	| character |
	startIndex to: startIndex + anInteger - 1 do:  [:index |
		buffer writeSize < 10 ifTrue: [destination write: buffer readSize from: bufferReading].
		character := aSequenceableCollection at: index.
		character == decodedLineEnd
			ifTrue:	[bufferWriting write: encodedLineEnd]
			ifFalse:	[encoder encode: character on: bufferWriting]].
	destination write: buffer readSize from: bufferReading.
	^anInteger
! !

!EncodeWriteStream methodsFor:'initialize-release'!

close
	super close.
	buffer recycle.
	buffer := nil
!

contentsSpecies

	^String
!

on: aSource encoding: anEncoding

	super on: aSource.
	encoder := Encoder for: anEncoding.
	buffer := RingBuffer new: DefaultBufferSize class: ByteArray.
	bufferReading := buffer reading.
	bufferWriting := buffer writing.
	self setLineEndAuto
! !

!EncodeWriteStream methodsFor:'line-end'!

setLineEndAuto

        OperatingSystem isMSWINDOWSlike
                ifTrue:         [self setLineEndCRLF]
                ifFalse:        [self setLineEndLF]
!

setLineEndCRLF

	| stream |
	decodedLineEnd := Character cr.
	stream := ByteArray new writing.
	encoder encode: Character cr on: stream; encode: Character lf on: stream.
	encodedLineEnd := stream contents
!

setLineEndLF

	| stream |
	decodedLineEnd := Character cr.
	stream := ByteArray new writing.
	encoder encode: Character lf on: stream.
	encodedLineEnd := stream contents
!

setLineEndTransparent

	decodedLineEnd := nil.
	encodedLineEnd := nil
! !

!EncodeWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__EncodeWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#InterpretedWriteStream
	instanceVariableNames:'elementSize cache cacheSize operation contentsSpecies'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

InterpretedWriteStream comment:'Converts consumed elements into bytes of pre-configured (primitive) CType, e.g. float, long etc. The type of the written elements must match the CType, the underlying destination must be binary.

Instance Variables
	elementSize	<Integer> byte size of elements of the pre-configured CType
	cache	<InterpretedBytes> caches the bytes so that they can be bulk written
	cacheSize	<SmallInteger> how many elements (not bytes) do we want to cache
	operation	<BlockClosure> CType translation primitive used to write into the buffer
	contentsSpecies	<Class> collection type to use to hold collections of elements

'
!


!InterpretedWriteStream class methodsFor:'instance creation'!

on: aWriteStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	^self new on: aWriteStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
!

on: aWriteStream type: aType cacheSize: aSize
	| interpretation |
	interpretation := InterpretedBytes perform: aType.
	^self on: aWriteStream bytesPerElement: (interpretation at: 1) contentsSpecies: (interpretation at: 2) operation: (interpretation at: 4) cacheSize: aSize
! !

!InterpretedWriteStream methodsFor:'accessing'!

insert: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[count = anInteger] whileFalse: 
		[amount := cacheSize min: anInteger - count.
		0 to: amount - 1 do:  [:index | operation value: cache value: index * elementSize + 1 value: (aSequenceableCollection at: index + startIndex)].
		destination insert: amount * elementSize from: cache at: 1.
		count := count + amount].
	^anInteger
!

put: anObject

	operation value: cache value: 1 value: anObject.
	destination write: elementSize from: cache at: 1.
	^anObject
!

write: anInteger from: aSequenceableCollection at: startIndex

	| count amount |
	count := 0.
	[count = anInteger] whileFalse: 
		[amount := cacheSize min: anInteger - count.
		0 to: amount - 1 do:  [:index | operation value: cache value: index * elementSize + 1 value: (aSequenceableCollection at: count + index + startIndex)].
		destination write: amount * elementSize from: cache at: 1.
		count := count + amount].
	^anInteger
! !

!InterpretedWriteStream methodsFor:'initialize-release'!

close
	super close.
	cache recycle.
	cache := nil
!

contentsSpecies
	^contentsSpecies
!

on: aWriteStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	super on: aWriteStream.
	cacheSize := aSize.
	elementSize := anInteger.
	contentsSpecies := aClass.
	operation := aBlock.
	cache := InterpretedBytes newRecycled: ((elementSize * cacheSize) max: DefaultBufferSize)
! !

!InterpretedWriteStream methodsFor:'seeking'!

++ anInteger

	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	[destination ++ anInteger * elementSize]
		on: Incomplete do: [:exception | (Incomplete count: exception count / elementSize) raise].
	^anInteger
!

-- anInteger
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	[destination -- anInteger * elementSize]
		on: Incomplete do: [:exception | (Incomplete count: exception count / elementSize) raise].
	^anInteger
!

length
	^destination length / elementSize
!

position
	^destination position / elementSize
!

position: aPosition

	^([ destination position: aPosition * elementSize ] on: Incomplete do: [ :ex | ex count ]) // elementSize
! !

!InterpretedWriteStream methodsFor:'testing'!

isPositionable

	^destination isPositionable
! !

!InterpretedWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__InterpretedWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

WriteStream subclass:#TransformWriteStream
	instanceVariableNames:'buffer block closeBlock process incompleteCount readReady
		writeReady closeReady'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Transforms'
!

TransformWriteStream comment:'Transform write stream provides the most expressive form of transformation. The transformation is described by a binary block that is given two arguments, @input and @output. The @input is a virtual stream of elements written into the stream. The @output is the destination stream under the transform stream. The block can read arbitrary amount of elements from @input (including none) and write arbitrary amount of elements into @output (including none). The block will be invoked as many times as necessary to consume everything written into the stream, or until an Incomplete is raised by the destination.

The closing behavior of the stream can be customized through the closeBlock. The default closeBlock simply propagates #close to the destination as with any other transform stream.

In some cases it might be desirable to tweak the buffering strategy of the virtual input stream. In that case the buffer of the stream can be set manually to any kind of Buffer that matches the requirements of the transformation.

From the point of view of the API, the TransformWriteStream is very much like the TransformReadStream. Notably any valid transform block should work the same way on either read or write stream without modification. However to preserve the invariants and expressivity of the transform block, the implementation is vastly different. Primarily it is necessary to convert all the writes into a virtual stream of written elements that can be passed into the transform block as the input stream. Consequently the transformation itself needs to be suspended if there weren''t enough elements written yet, to complete an iteration of the transform block. Therefore it needs to run in its own process. Any writes get redirected into an internal buffer and a background process repeatedly invokes the transform block to drain the contents of the buffer and produces output into the destination. Obviously buffer access has to be synchronized between any writing threads and the background process. The readReady/writeReady semaphores work in a lock-step mode, to interleave the background buffer draining with any writes.

Instance Variables
	buffer	<Buffer> holds the contents of the virtual input stream
	block	<BlockClosure> binary transformation block that reads elements from input (first argument) and writes elements into output (second argument)
	closeBlock	<BlockClosure> binary block invoked in response to the #close message, allows customizing the close behavior
	process	<Process> background process that runs the transformation block
	incompleteCount	<Integer> indicates that the transformation raised or received Incomplete and how many elements were actually consumed by the transformation block so that we can reraise Incomplete with correct count in the client thread
	readReady	<Semaphore> signals to the background process that elements were written into the buffer
	writeReady	<Semaphore> gates any writes into the stream, making sure background process is not draining the buffer at the same time
	closeReady	<Semaphore> signals back to the user thread that the background process finished draining the buffer and the stream is properly closed, so the #close call can return

'
!


!TransformWriteStream class methodsFor:'instance creation'!

on: aWriteStream block: block
	^self new on: aWriteStream block: block
! !

!TransformWriteStream methodsFor:'accessing'!

block
	^block
!

buffer
	^buffer
!

closeBlock
	^closeBlock
!

insert: anInteger from: aSequenceableCollection at: startIndex
	| count amount |
	anInteger isZero ifTrue: [^0].

	count := 0.
	[count < anInteger] whileTrue:
		[amount := anInteger - count.
		buffer hasFixedWriteSpace ifTrue: [amount := amount min: buffer cacheSize].
		buffer insert: amount from: aSequenceableCollection at: startIndex + count.

		"There is now data in the buffer for the drain to read"
		readReady signal.
		writeReady wait.
		incompleteCount == nil ifFalse: [(Incomplete count: count + incompleteCount) raise].
		count := count + amount ].
	^anInteger
!

put: anObject
	incompleteCount == nil ifFalse: [Incomplete zero raise].

	buffer put: anObject.

	"There is now data in the buffer for the drain to read"
	readReady signal.
	writeReady wait
!

write: anInteger from: aSequenceableCollection at: startIndex
	| count amount |
	anInteger isZero ifTrue: [^0].

	count := 0.
	[count < anInteger] whileTrue:
		[amount := anInteger - count.
		buffer hasFixedWriteSpace ifTrue: [amount := amount min: buffer cacheSize].
		buffer write: amount from: aSequenceableCollection at: startIndex + count.
		
		"There is now data in the buffer for the drain to read"
		readReady signal.
		writeReady wait.
		incompleteCount == nil ifFalse: [(Incomplete count: count + incompleteCount) raise].
		count := count + amount ].
	^anInteger
! !

!TransformWriteStream methodsFor:'initialize-release'!

buffer: aBuffer
	buffer := aBuffer.
	self drainBuffer
!

close
	buffer ifNil: [^self].
	"Write nothing to the buffer, but signal that there is data to read, causing the drain to throw Incomplete"
	readReady signal.

	"Wait for the drain to finish up completely. Rearm the closeReady incase somebody calls #close again."
	closeReady wait.
	closeReady signal.

	closeBlock cull: destination cull: self.

	buffer recycle.
	buffer := nil
!

closeBlock: anObject
	closeBlock := anObject
!

contentsSpecies
	^buffer contentsSpecies
!

contentsSpecies: aClass

	self buffer: (buffer class new: buffer cacheSize class: aClass)
!

on: aStreamable block: aBlock
	super on: aStreamable.
	block := aBlock.
	incompleteCount := nil.
	closeBlock := [ :destinationStream | destinationStream close].
	buffer := ElasticBuffer new: DefaultBufferSize class: aStreamable contentsSpecies.
	self drainBuffer
! !

!TransformWriteStream methodsFor:'printing'!

streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		space;
		write: '#';
		write: block method homeMethod selector;
		write: ' buffered: ';
		print: buffer writeSize.
	buffer writeSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsPast
! !

!TransformWriteStream methodsFor:'private'!

drainBuffer
	| reading |
	process ifNotNil: [process terminate].
	incompleteCount == nil ifFalse: [^self].

	closeReady := Semaphore new.
	readReady := Semaphore new.
	writeReady := Semaphore new.
	reading := buffer reading transforming: [:in :out |
		| count |
		"Wait for the main process to have written to the buffer"
		readReady wait.

		"If nothing was written to the buffer, this indicates we're closing, we raise Incomplete"
		(count := buffer readSize) isZero ifTrue: [Incomplete zero raise].
		out write: count from: in.

		"Allow the main process to write to the buffer"
		writeReady signal].
	process := [
		[[block value: reading value: destination] repeat] on: Incomplete do: [].
		incompleteCount := reading buffer readPosition.

		"Signal that we're closed so that an attempt to write or close will immediately complete"
		writeReady signal.
		closeReady signal]
			newProcess.
	process resume
! !

!TransformWriteStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__TransformWriteStream.st 73 2012-01-30 22:30:43Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:43 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms' }"

"{ NameSpace: Xtreams }"

ReadStream subclass:#ObjectAnalyseStream
	instanceVariableNames:'marshaler nothing log depth objects int8 int16 int32 int64 uint16
		uint32 uint64 float double'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms'
!


!ObjectAnalyseStream class methodsFor:'instance creation'!

on: aDestination
	^self on: aDestination marshaler: ObjectMarshaler new
!

on: aDestination marshaler: aMarshaler
	^self new on: aDestination marshaler: aMarshaler
! !

!ObjectAnalyseStream methodsFor:'accessing'!

get
	| details |
	marshaler analyse: self.
	details := log conclusion.
	log := String new writing.
	self complete.
	^details
!

read: anInteger into: aSequenceableCollection at: startIndex
	| count |
	count := 0.
	[anInteger timesRepeat:
		[marshaler analyse: self.
		aSequenceableCollection at: startIndex + count put: log conclusion.
		log := String new writing.
		self complete.
		count := count + 1]]
			on: Incomplete do: [:exception |
				aSequenceableCollection at: startIndex + count put: log conclusion.
				log := String new writing.
				self complete.
				(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
	^anInteger
! !

!ObjectAnalyseStream methodsFor:'initialize-release'!

contentsSpecies
	^Array
!

on: aSource marshaler: aMarshaler
	super on: aSource.
	marshaler := aMarshaler.
	nothing := Object new.
	objects := OrderedCollection with: Transcript.
	depth := 0.

	log := String new writing.
	int8 := aSource interpreting: #signedChar.
	(self log: 'header' do: [marshaler configureAnalyse: aSource])
		ifTrue: [
			int16 := aSource interpreting: #signedShort_be.
			int32 := aSource interpreting: #signedLong_be.
			int64 := aSource interpreting: #signedLonglong_be.
			uint16 := aSource interpreting: #unsignedShort_be.
			uint32 := aSource interpreting: #unsignedLong_be.
			uint64 := aSource interpreting: #unsignedLonglong_be]
		ifFalse: [
			int16 := aSource interpreting: #signedShort_le.
			int32 := aSource interpreting: #signedLong_le.
			int64 := aSource interpreting: #signedLonglong_le.
			uint16 := aSource interpreting: #unsignedShort_le.
			uint32 := aSource interpreting: #unsignedLong_le.
			uint64 := aSource interpreting: #unsignedLonglong_le].
	float := aSource interpreting: #float.
	double := aSource interpreting: #double
! !

!ObjectAnalyseStream methodsFor:'primitives'!

double
	^double
!

float
	^float
!

int16
	^int16
!

int32
	^int32
!

int64
	^int64
!

int8
	^int8
!

uint16
	^uint16
!

uint32
	^uint32
!

uint64
	^uint64
!

uint8
	^source
! !

!ObjectAnalyseStream methodsFor:'private'!

complete
	objects := OrderedCollection with: Transcript
!

log: type do: aBlock
	| superlog sublog position incomplete |
	position := source position.
	superlog := log.
	log := String new writing.

	depth := depth + 1.
	incomplete := false.
	^[aBlock on: Incomplete do: [:ex | incomplete := true. ex pass]] ensure:
		[depth := depth - 1.
		sublog := log conclusion.
		log := superlog.

		incomplete ifFalse:
			[log tab: depth; print: position; write: '+'; print: (source position - position); tab.
			type isCharacters
				ifTrue:	[log write: type]
				ifFalse:	[log write: type value].
			log cr; write: sublog]]
!

nothing
	^nothing
!

objects
	^objects
! !

!ObjectAnalyseStream class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ObjectAnalyseStream.st 73 2012-01-30 22:30:43Z mkobetic $'
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

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]
! !

!WriteStream methodsFor:'transforming'!

doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectWriteSteam>
	""
		(Array new writing doing: [ :e | Transcript space; print: e * e ]) write: (1 to: 10); conclusion
	"
	^self collecting: [:each | (aBlock value: each). each]
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'interpreting'!

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
! !

!WriteStream methodsFor:'interpreting'!

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
! !

!WriteStream methodsFor:'interpreting'!

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
! !

!WriteStream methodsFor:'interpreting'!

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
! !

!WriteStream methodsFor:'interpreting'!

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

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

pairing
	"Transform a stream of elements in to a stream of associations between even+odd elements of the stream. This expects the stream to have an even number of elements"

	^self transforming: [:in :out | out put: (Association key: in get value: in get)]
! !

!WriteStream methodsFor:'transforming'!

positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <WriteStream>   a positionable read stream
	""
		[ :x | Transcript space; print: x ] writing positioning write: (1 to: 10); -- 5; write: (11 to: 15); close
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionWriteStream on: self]
! !

!WriteStream methodsFor:'transforming'!

rejecting: aBlock
	"Filters written elements using aBlock. aBlock has the same form and semantics as the #reject: block on collections."
	"	aBlock	<BlockClosure>	usual #reject: style block used to filter the elements passing through
		^<TransformWriteStream>"
	"
		(Array new writing rejecting: [ :e | e odd ]) write: (1 to: 10); conclusion
	"
	^self selecting: [:each | (aBlock cull: each) not]
! !

!WriteStream methodsFor:'transforming'!

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
! !

!WriteStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

depairing
	"Transform a stream of associations in to a stream of elements made up of the key and value association components."

	^self transforming: [:in :out |
		| association |
		association := in get.
		out put: association key.
		out put: association value]
! !

!ReadStream methodsFor:'transforming'!

doing: aBlock
	"Perform and action with each passing element using #do: style block."
	"	aBlock	<BlockClosure>	a #do: style block invoked with each element as it passes through the stream
		^<CollectReadSteam>
	""
		((1 to: 5) reading doing: [ :e | Transcript space; print: e * e ]) rest
	"
	^self collecting: [:each | (aBlock value: each). each]
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'interpreting'!

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
! !

!ReadStream methodsFor:'interpreting'!

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
! !

!ReadStream methodsFor:'interpreting'!

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
! !

!ReadStream methodsFor:'interpreting'!

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
! !

!ReadStream methodsFor:'interpreting'!

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

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

pairing
	"Transform a stream of elements in to a stream of associations between even+odd elements of the stream. This expects the stream to have an even number of elements"

	^self transforming: [:in :out | out put: (Association key: in get value: in get)]
! !

!ReadStream methodsFor:'transforming'!

positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <ReadStream>    a positionable read stream
	""
		[ Time now ] reading positioning ++ 3; -- 2; get
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionReadStream on: self]
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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
! !

!ReadStream methodsFor:'transforming'!

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

