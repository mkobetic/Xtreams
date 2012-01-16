'From Smalltalk/X, Version:6.2.1 on 16-01-2012 at 01:02:26 AM'                  !

"{ Package: 'stx:goodies/xtreams/support' }"

LibraryDefinition subclass:#stx_goodies_xtreams_support
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_support class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 16 2011-11-21 06:02:29Z mkobetic $'
! !

!stx_goodies_xtreams_support class methodsFor:'description'!

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
        #'stx:libbasic'    "Object - superclass of Xtreams::stx_goodies_xtreams_support "
    )
! !

!stx_goodies_xtreams_support class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'Xtreams::Encoder'
        #'Xtreams::RecyclingCenter'
        #'Xtreams::XtreamsPool'
        #'Xtreams::stx_goodies_xtreams_support'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        Block cull:
        Block cull:cull:
        Object isFixedArgument
        SequenceableCollection copyGrownToAtLeast:
        SequenceableCollection recycle
        Symbol cull:
        #'UnixOperatingSystem::FileDescriptorHandle' fileSize
        'SequenceableCollection class' newRecycled:
    )
! !

!stx_goodies_xtreams_support class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_support class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/support/stx_goodies_xtreams_support.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'31'"$"
! !

!stx_goodies_xtreams_support class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_support.st 16 2011-11-21 06:02:29Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 16-01-2012 at 01:02:26 AM'                  !

"{ Package: 'stx:goodies/xtreams/support' }"

"{ NameSpace: Xtreams }"

Object subclass:#Encoder
	instanceVariableNames:''
	classVariableNames:'DialectEncoder Encoders'
	poolDictionaries:''
	category:'Xtreams-Support'
!

Encoder comment:'Abstract character encoder class defines the API and maintains a registry of known encoders (Encoders). Also provides a hook to allow plugging in dialect specific encoders (DialectEncoder) as a secondary encoder resource.

Shared Variables
	DialectEncoder	<Class> optional dialect specific encoder class providing support for additional encodings
	Encoders	<Dictionary key: Symbol value: Class> maps encoding names to encoders

'
!


!Encoder class methodsFor:'instance creation'!

for: anEncoding

        anEncoding isSymbol ifFalse: [ ^anEncoding streamingAsEncoder ].
        ^Encoders at: anEncoding ifAbsent: [
                DialectEncoder
                        ifNil: [ self error: 'Unknown encoding!!' ]
                        ifNotNil: [ DialectEncoder for: anEncoding ] ]
!

streamingAsEncoder

	^self new
! !

!Encoder class methodsFor:'accessing'!

encoders

	^Encoders ifNil: [ Encoders := IdentityDictionary new ]
! !

!Encoder methodsFor:'accessing'!

backupState
!

decodeFrom: aReadStream

	^self subclassResponsibility
!

encode: aCharacter on: aWriteStream

	^self subclassResponsibility
!

restoreState
!

streamingAsEncoder

	^self
! !

!Encoder class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__Encoder.st 7 2011-08-22 15:51:21Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 16-01-2012 at 01:02:26 AM'                  !

"{ Package: 'stx:goodies/xtreams/support' }"

"{ NameSpace: Xtreams }"

Object subclass:#RecyclingCenter
	instanceVariableNames:'recycled mutex'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Support'
!

RecyclingCenter class instanceVariableNames:'objectspace1 fixedspace1 objectspaceN fixedspaceN cacheSize'

"
 No other class instance variables are inherited by this class.
"
!

RecyclingCenter comment:'Instance Variables
	recycled	<IdentityDictionary key: Class value: (Array of: SequenceableCollection)> caches fixed number of collections (3) per sequenceable collection class
	mutex	<Semaphore>

Class Instance Variables
	objectspace1	<RecyclingCenter> old space collections size 1
	fixedspace1	<RecyclingCenter> fixed space collections size 1
	objectspaceN	<RecyclingCenter> old space collections of cacheSize
	fixedspaceN	<RecyclingCenter> fixed space collection of cacheSize
	cacheSize	<SmallInteger> default collection size

'
!


!RecyclingCenter class methodsFor:'class initialization'!

initialize
        | cacheLimit |
        cacheSize := DefaultBufferSize.
        cacheLimit := 3.
        objectspace1 := self new initialize: cacheLimit.
        fixedspace1 := self new initialize: cacheLimit.
        objectspaceN := self new initialize: cacheLimit.
        fixedspaceN := self new initialize: cacheLimit
! !

!RecyclingCenter class methodsFor:'recycling'!

new: anInteger class: aClass
	anInteger == 1 ifTrue: [^objectspace1 new: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^objectspaceN new: anInteger class: aClass].
	^aClass withSize: anInteger
!

newInFixedSpace: anInteger class: aClass
	anInteger == 1 ifTrue: [^fixedspace1 newInFixedSpace: anInteger class: aClass].
	anInteger == cacheSize ifTrue: [^fixedspaceN newInFixedSpace: anInteger class: aClass].
	^aClass newInFixedSpace: anInteger
!

recycle: aCollection
	aCollection == nil ifTrue: [^nil].
	aCollection isFixedArgument
		ifTrue:
			[aCollection size == 1 ifTrue: [fixedspace1 recycle: aCollection].
			aCollection size == cacheSize ifTrue: [fixedspaceN recycle: aCollection]]
		ifFalse:
			[aCollection size == 1 ifTrue: [objectspace1 recycle: aCollection].
			aCollection size == cacheSize ifTrue: [objectspaceN recycle: aCollection]]
! !

!RecyclingCenter methodsFor:'initialize-release'!

initialize: aCacheLimit
	mutex := Semaphore forMutualExclusion.
	recycled := IdentityDictionary new.
	SequenceableCollection allSubclassesDo: [:aClass | recycled at: aClass put: (Array new: aCacheLimit)].
	recycled at: InterpretedBytes put: (Array new: aCacheLimit)
! !

!RecyclingCenter methodsFor:'recycling'!

existing: aClass
        | queue collection |
        queue := recycled at: aClass.
        mutex critical: [
        1 to: queue size do: [:index |
                collection := queue at: index.
                collection == nil ifFalse:
                        [queue at: index put: nil.
                        mutex signal.
                        ^collection]]].
        ^nil
!

new: anInteger class: aClass
	| collection |
	(collection := self existing: aClass) == nil ifTrue: [collection := aClass withSize: anInteger].
	^collection
!

newInFixedSpace: anInteger class: aClass
	| collection |
	(collection := self existing: aClass) == nil ifTrue: [collection := aClass newInFixedSpace: anInteger].
	^collection
!

recycle: aCollection
        | queue |
        queue := recycled at: aCollection class.
        mutex critical: [
        1 to: queue size do: [:index |
                (queue at: index) == nil ifTrue:
                        [queue at: index put: aCollection.
                        mutex signal.
                        ^self]]]
! !

!RecyclingCenter class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__RecyclingCenter.st 7 2011-08-22 15:51:21Z mk $'
! !

RecyclingCenter initialize!
'From Smalltalk/X, Version:6.2.1 on 16-01-2012 at 01:02:26 AM'                  !

"{ Package: 'stx:goodies/xtreams/support' }"

"{ NameSpace: Xtreams }"

ByteArray variableByteSubclass:#InterpretedBytes
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Support'
!

!InterpretedBytes class methodsFor:'instance creation'!

withSize: anInteger
	^self new: anInteger
! !

!InterpretedBytes class methodsFor:'type descriptions'!

char

	^(Array with: 1 with: ByteArray with: [:b :i | b byteAt: i] with: [:b :i :o | b byteAt: i put: o])
!

double

	^(Array with: 8 with: "DoubleArray" Array with: [:b :i | b doubleAt: i] with: [:b :i :o | b doubleAt: i put: o])
!

double_be

	self isBigEndian ifTrue: [ ^self double ].
	^(Array with: 8 with: "DoubleArray" Array with: [:b :i | b doubleAt: i bigEndian: true] with: [:b :i :o | b doubleAt: i put: o bigEndian: true])
!

double_le

	self isBigEndian ifFalse: [ ^self double ].
	^(Array with: 8 with: "DoubleArray" Array with: [:b :i | b doubleAt: i bigEndian: false] with: [:b :i :o | b doubleAt: i put: o bigEndian: false])
!

float

	^(Array with: 4 with: "FloatArray" Array with: [:b :i | b floatAt: i] with: [:b :i :o | b floatAt: i put: o])
!

float_be

	self isBigEndian ifTrue: [ ^self float ].
	^(Array with: 4 with: "FloatArray" Array with: [:b :i | b floatAt: i bigEndian: true] with: [:b :i :o | b floatAt: i put: o bigEndian: true])
!

float_le

	self isBigEndian ifFalse: [ ^self float ].
	^(Array with: 4 with: "FloatArray" Array with: [:b :i | b floatAt: i bigEndian: false] with: [:b :i :o | b floatAt: i put: o bigEndian: false])
!

long

	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i] with: [:b :i :o | b unsignedLongAt: i put: o])
!

long_be

	self isBigEndian ifTrue: [ ^self long ].
	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i bigEndian: true ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: true])
!

long_le

	self isBigEndian ifFalse: [ ^self long ].
	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i bigEndian: false ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: false])
!

longlong

	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i] with: [:b :i :o | b unsignedLongLongAt: i put: o])
!

longlong_be

	self isBigEndian ifTrue: [ ^self longlong ].
	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i bigEndian: true] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: true])
!

longlong_le

	self isBigEndian ifFalse: [ ^self longlong ].
	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i bigEndian: false] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: false])
!

short

	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i] with: [:b :i :o | b unsignedShortAt: i put: o]
!

short_be

	self isBigEndian ifTrue: [ ^self short ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: true ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: true ]
!

short_le

	self isBigEndian ifFalse: [ ^self short ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: false ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: false ]
!

signedChar

	^(Array with: 1 with: Array with: [:b :i | b signedByteAt: i] with: [:b :i :o | b signedByteAt: i put: o])
!

signedLong

	^(Array with: 4 with: Array with: [:b :i | b longAt: i] with: [:b :i :o | b longAt: i put: o])
!

signedLong_be

	self isBigEndian ifTrue: [ ^self signedLong ].
	^(Array with: 4 with: Array with: [:b :i | b longAt: i bigEndian: true ] with: [:b :i :o | b longAt: i put: o bigEndian: true])
!

signedLong_le

	self isBigEndian ifFalse: [ ^self signedLong ].
	^(Array with: 4 with: Array with: [:b :i | b longAt: i bigEndian: false ] with: [:b :i :o | b longAt: i put: o bigEndian: false])
!

signedLonglong

	^(Array with: 8 with: Array with: [:b :i | b longLongAt: i] with: [:b :i :o | b longLongAt: i put: o])
!

signedLonglong_be

	self isBigEndian ifTrue: [ ^self signedLonglong ].
	^(Array with: 8 with: Array with: [:b :i | b longLongAt: i bigEndian: true] with: [:b :i :o | b longLongAt: i put: o bigEndian: true])
!

signedLonglong_le

	self isBigEndian ifFalse: [ ^self signedLonglong ].
	^(Array with: 8 with: Array with: [:b :i | b longLongAt: i bigEndian: false] with: [:b :i :o | b longLongAt: i put: o bigEndian: false])
!

signedShort

	^(Array with: 2 with: Array with: [:b :i | b shortAt: i] with: [:b :i :o | b shortAt: i put: o])
!

signedShort_be

	self isBigEndian ifTrue: [ ^self signedShort ].
	^Array with: 2 with: Array with: [:b :i | b shortAt: i bigEndian: true ] with: [:b :i :o | b shortAt: i put: o bigEndian: true ]
!

signedShort_le

	self isBigEndian ifFalse: [ ^self signedShort ].
	^Array with: 2 with: Array with: [:b :i | b shortAt: i bigEndian: false ] with: [:b :i :o | b shortAt: i put: o bigEndian: false ]
!

tlsUint24

	^Array
		with: 3
		with: Array
		with: [ :b :i | ((((b byteAt: i) bitShift: 8) + (b byteAt: i + 1)) bitShift: 8) + (b byteAt: i + 2) ]
		with: [ :b :i :o |
			b       byteAt: i put: (o bitShift: -16);
				byteAt: i + 1 put: ((o bitShift: -8) bitAnd: 255);
				byteAt: i + 2 put: (o bitAnd: 255) ]
!

unsignedChar

	^(Array with: 1 with: ByteArray with: [:b :i | b byteAt: i] with: [:b :i :o | b byteAt: i put: o])
!

unsignedLong

	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i] with: [:b :i :o | b unsignedLongAt: i put: o])
!

unsignedLong_be

	self isBigEndian ifTrue: [ ^self unsignedLong ].
	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i bigEndian: true ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: true])
!

unsignedLong_le

	self isBigEndian ifFalse: [ ^self unsignedLong ].
	^(Array with: 4 with: DwordArray with: [:b :i | b unsignedLongAt: i bigEndian: false ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: false])
!

unsignedLonglong

	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i] with: [:b :i :o | b unsignedLongLongAt: i put: o])
!

unsignedLonglong_be

	self isBigEndian ifTrue: [ ^self unsignedLonglong ].
	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i bigEndian: true] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: true])
!

unsignedLonglong_le

	self isBigEndian ifFalse: [ ^self unsignedLonglong ].
	^(Array with: 8 with: Array with: [:b :i | b unsignedLongLongAt: i bigEndian: false] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: false])
!

unsignedShort

	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i] with: [:b :i :o | b unsignedShortAt: i put: o]
!

unsignedShort_be

	self isBigEndian ifTrue: [ ^self unsignedShort ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: true ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: true ]
!

unsignedShort_le

	self isBigEndian ifFalse: [ ^self unsignedShort ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: false ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: false ]
! !

!InterpretedBytes class methodsFor:'xtreams'!

newInFixedSpaceRecycled: size

	^RecyclingCenter newInFixedSpace: size class: self
!

newInFixedSpaceRecycledDefaultSize

	^self newInFixedSpaceRecycled: DefaultBufferSize
!

newRecycled: size

	^RecyclingCenter new: size class: self
!

newRecycledDefaultSize

	^self newRecycled: DefaultBufferSize
! !

!InterpretedBytes methodsFor:'accessing'!

recycle

        RecyclingCenter recycle: self
! !

'From Smalltalk/X, Version:6.2.1 on 16-01-2012 at 01:02:26 AM'                  !

"{ Package: 'stx:goodies/xtreams/support' }"

"{ NameSpace: Xtreams }"

SharedPool subclass:#XtreamsPool
	instanceVariableNames:''
	classVariableNames:'DefaultBufferSize LF CR'
	poolDictionaries:''
	category:'Xtreams-Support'
!


!XtreamsPool class methodsFor:'initialization'!

initialize

    DefaultBufferSize := 32768.
    LF := Character value: 10.
    CR := Character value: 13.
! !

!XtreamsPool class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !

XtreamsPool initialize!
!Symbol methodsFor:'xtreams'!

cull: anObject

    ^anObject perform: self
! !

!OrderedCollection methodsFor:'xtreams'!

copyGrownToAtLeast: newSize

    self grow: newSize
! !

!Block methodsFor:'xtreams'!

cull: value

    ^self numArgs = 1 ifTrue: [ self value: value ] ifFalse: [ self value ]
! !

!Block methodsFor:'xtreams'!

cull: value1 cull: value2

    ^self numArgs < 2 ifTrue: [ self cull: value1 ] ifFalse: [ self value: value1 value: value2 ]
! !

!Behavior methodsFor:'xtreams'!

absoluteName

        ^self name
! !

!SequenceableCollection methodsFor:'xtreams'!

copyGrownToAtLeast: newSize

    |newCollection|

    newCollection := self class new: newSize.
    newCollection replaceFrom: 1 to: self size with: self startingAt: 1.
    ^newCollection
! !

!SequenceableCollection methodsFor:'xtreams'!

recycle

    Xtreams::RecyclingCenter recycle: self
! !


!UnixOperatingSystem::FileDescriptorHandle methodsFor:'xtreams'!

fileSize

    | error size |
%{
    struct stat buf;

    if (__isSmallInteger(__INST(fd))) {
        if (fstat(__smallIntegerVal(__INST(fd)), &buf) >= 0) {
           if (sizeof(buf.st_size) == 8) {
              size = __MKINT64(&buf.st_size);
           } else {
               size = __MKINT(buf.st_size);
           };
        } else {
           error = __mkSmallInteger(errno);
        };
    }
%}.
    ^size notNil
        ifTrue: [ size ]
        ifFalse: [ self error: error ]

"
    | h |
    h := OperatingSystem openFileForRead: '/etc/hosts'.
    [ h fileSize ] ensure: [ h close ]
"
! !

!Object methodsFor:'private'!

isFixedArgument

    ^false
! !

