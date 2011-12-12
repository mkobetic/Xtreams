'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:48 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#InterpretingStreamTest
	instanceVariableNames:'stream'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms-Tests'
!


!InterpretingStreamTest methodsFor:'tests'!

testDouble
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #double.
	interpreting put: (SmallInteger minVal - 1.5).
	interpreting put: (SmallInteger maxVal + 1.5).
	interpreting := stream contents reading interpreting: #double.
	self assert: interpreting get = (SmallInteger minVal - 1.5).
	self assert: interpreting get = (SmallInteger maxVal + 1.5)
!

testFloat
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #float.
	-50.0 to: 50.0 by: 0.5 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #float) rest = (-50 to: 50 by: 0.5)
!

testSignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedChar.
	-120 to: 120 do: [:each | interpreting put: each].
	interpreting := stream contents reading interpreting: #signedChar.
	self assert: interpreting rest = (-120 to: 120)
!

testSignedLong
	| interpreting negative positive |
	stream := ByteArray new writing.
	negative := -268435456. "SmallInteger minVal // 2 in 32-bits"
	positive :=  268435455. "SmallInteger maxVal // 2 in 32-bits"
	interpreting := stream interpreting: #signedLong.
	interpreting put: negative.
	interpreting put: positive.
	interpreting := stream contents reading interpreting: #signedLong.
	self assert: interpreting get = negative.
	self assert: interpreting get = positive
!

testSignedLonglong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedLonglong.
	interpreting put: (SmallInteger minVal // 2) - 1.
	interpreting put: (SmallInteger maxVal // 2) + 1.
	interpreting := stream contents reading interpreting: #signedLonglong.
	self assert: interpreting get = ((SmallInteger minVal // 2) - 1).
	self assert: interpreting get = ((SmallInteger maxVal // 2) + 1)
!

testSignedShort
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedShort.
	interpreting put: -31000.
	interpreting put: 31000.
	interpreting := stream contents reading interpreting: #signedShort.
	self assert: interpreting get = -31000.
	self assert: interpreting get = 31000
!

testUnsignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #char.
	0 to: 255 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #char) rest asArray = (0 to: 255)
!

testUnsignedLong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #long.
	65000 to: 70000 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #long) rest asArray = (65000 to: 70000)
!

testUnsignedLongLong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #longlong.
	(SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100) do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #longlong) rest = ((SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100))
!

testUnsignedShort
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #short.
	250 to: 270 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #short) rest asArray = (250 to: 270)
! !

!InterpretingStreamTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:48 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#DuplicateTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms-Tests'
!


!DuplicateTest methodsFor:'tests'!

testDuplicateReading
	| copy |
	copy := Array new writing.
	self assert: ((0 to: 255) reading duplicating: copy) rest = copy conclusion
!

testDuplicateReadingIncomplete
	| original copy |
	copy := ByteArray new writing.
	[(#[0 1 2 3 4 5 6 7 8 9] reading duplicating: copy) read: 20] on: Incomplete do: [:incomplete | original := incomplete contents].
	copy := copy conclusion.
	self assert: original = #[0 1 2 3 4 5 6 7 8 9].
	self assert: copy = #[0 1 2 3 4 5 6 7 8 9]
!

testDuplicateWriting
	| original copy |
	original := ByteArray new writing.
	copy := ByteArray new writing.
	(original duplicating: copy) write: (0 to: 255).
	self assert: original conclusion = copy conclusion
!

testDuplicateWritingIncomplete
	| original copy |
	original := ByteArray new writing.
	copy := ByteArray new writing.
	[((original limiting: 10) duplicating: copy) write: (0 to: 255)] on: Incomplete do: [:incomplete | ].
	original := original conclusion.
	copy := copy conclusion.
	self assert: original = #[0 1 2 3 4 5 6 7 8 9].
	self assert: copy = #[0 1 2 3 4 5 6 7 8 9]
! !

!DuplicateTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:48 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#MessagePackMarshalerTest
	instanceVariableNames:'stream marshaling log bytes marshaler'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms-Tests'
!


!MessagePackMarshalerTest methodsFor:'initialize-release'!

setUp
	marshaler := MessagePackMarshaler new.
	stream := ByteArray new writing.
	marshaling := stream marshaling: marshaler.
	bytes := nil.
	log := nil
! !

!MessagePackMarshalerTest methodsFor:'private'!

analyse
	"Run an analysis on the stream contents to ensure it has integrity"
	bytes := stream conclusion.
	log := String new writing.
	(ObjectAnalyseStream on: bytes reading marshaler: marshaler class new) do: [:each | log write: each].
	log := log conclusion.
	marshaling := bytes reading marshaling: marshaler class new
! !

!MessagePackMarshalerTest methodsFor:'tests'!

testArray
	| fixed small big |
	big := Array new: 65537 withAll: 1.
	small := (1 to: 255) asArray.
	fixed := Array with: small with: big.
	marshaling put: fixed.
	marshaling put: small.
	marshaling put: big.
	self analyse.
	self assert: marshaling get = fixed.
	self assert: marshaling get = small.
	self assert: marshaling get = big
!

testDictionary
	| fixed small big |
	big := Dictionary new: 65537.
	1 to: 65537 do: [:i | big at: i put: 1].
	small := Dictionary new: 255.
	1 to: 255 do: [:i | small at: i put: i].
	fixed := Dictionary new
		at: 1 put: big;
		at: 2 put: small;
		yourself.
	marshaling put: fixed.
	marshaling put: small.
	marshaling put: big.
	self analyse.
	self assert: marshaling get = fixed.
	self assert: marshaling get = small.
	self assert: marshaling get = big
!

testFloatDouble
	marshaling write: #(3.14 3.14159 3.141592653589793).
	self analyse.
	self assert: marshaling rest = #(3.14 3.14159 3.141592653589793)
!

testIntegers
	| inrange outofrange |
	outofrange := #(18446744073709551616 -9223372036854775809).
	inrange := #(
		0 1 126 127 128 255 256
		32767 32768 32769
		65535 65536 65537
		4294967294 4294967295 4294967296
		18446744073709551614 18446744073709551615
		-1 -2 -32 -33
		-127 -128 -255 -256
		-32767 -32768 -32769
		-65535 -65536 -65537
		-2147483647 -2147483648 -2147483649
		-9223372036854775807 -9223372036854775808).

	marshaling write: inrange.
	outofrange do: [:each | self should: [marshaling put: each] raise: Error].
	self analyse.
	self assert: marshaling rest = inrange
!

testRaw
	| big |
	big := ByteArray new: 100000 withAll: 1.
	marshaling put: #[10 255 0].
	marshaling put: (ByteArray withAll: (1 to: 255)).
	marshaling put: big.
	self analyse.
	self assert: marshaling get = #[10 255 0].
	self assert: marshaling get = (ByteArray withAll: (1 to: 255)).
	self assert: marshaling get = big
!

testSingletons
	marshaling put: nil.
	marshaling put: true.
	marshaling put: false.
	self analyse.
	self assert: marshaling get = nil.
	self assert: marshaling get = true.
	self assert: marshaling get = false
! !

!MessagePackMarshalerTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:48 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#ObjectMarshalerTest
	instanceVariableNames:'stream marshaling log bytes marshaler'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Transforms-Tests'
!


!ObjectMarshalerTest methodsFor:'initialize-release'!

setUp
	marshaler := ObjectMarshaler new.
	stream := ByteArray new writing.
	marshaling := stream marshaling: marshaler.
	bytes := nil.
	log := nil
! !

!ObjectMarshalerTest methodsFor:'private'!

analyse
	"Run an analysis on the stream contents to ensure it has integrity"
	bytes := stream conclusion.
	log := String new writing.
	(ObjectAnalyseStream on: bytes reading marshaler: marshaler class new) do: [:each | log write: each].
	log := log conclusion.
	marshaling := bytes reading marshaling: marshaler class new
! !

!ObjectMarshalerTest methodsFor:'tests'!

testArray
	marshaling put: (Array with: 1 with: -2.7 with: true).
	self analyse.
	self assert: marshaling get = (Array with: 1 with: -2.7 with: true)
!

testBlockClosureClean
	marshaling put: [].
	marshaling put: [:x :y | x + y].
	self analyse.
	self assert: marshaling get value = nil.
	self assert: (marshaling get value: 2 value: 3) = 5
!

testBlockClosureDirty
	| a a_original a_copy |
	a := 1.
	a_original := [a].
	marshaling put: a_original.
	self analyse.
	a_copy := marshaling get.
	self assert: a_original value = 1.
	self assert: a_copy value = 1.
	a := 2.
	self assert: a_original value = 2.
	self assert: a_copy value = 1
!

testCharacters
	marshaling write: 'testing'.
	self analyse.
	self assert: marshaling rest = #( $t $e $s $t $i $n $g )
!

testClass
	marshaling put: UndefinedObject.
	marshaling put: ObjectMarshalerTest.
	self analyse.
	self assert: marshaling get = UndefinedObject.
	self assert: marshaling get = ObjectMarshalerTest
!

testDictionary
	| result |
	marshaling put: (Dictionary new at: 1 put: 'one'; at: #two put: 2; at: 'three' put: (4 @ 5); yourself).
	self analyse.
	result := marshaling get.
	self assert: (result at: 1) = 'one'.
	self assert: (result at: #two) = 2.
	self assert: (result at: 'three') = (4 @ 5)
!

testFloat
	marshaling put: 5.4.
	marshaling put: -172.11102.
	self analyse.
	self assert: marshaling get = 5.4.
	self assert: marshaling get = -172.11102
!

testInteger
	marshaling put: 0.
	marshaling put: 1.
	marshaling put: 255.
	marshaling put: 254.
	marshaling put: -1.
	marshaling put: SmallInteger maxVal.
	marshaling put: SmallInteger minVal.
	self analyse.
	self assert: marshaling get = 0.
	self assert: marshaling get = 1.
	self assert: marshaling get = 255.
	self assert: marshaling get = 254.
	self assert: marshaling get = -1.
	self assert: marshaling get = SmallInteger maxVal.
	self assert: marshaling get = SmallInteger minVal.
!

testInterval
	marshaling put: (1 to: 12 by: 2).
	self analyse.
	self assert: marshaling get = (1 to: 11 by: 2)
!

testLargeInteger
	marshaling put: SmallInteger maxVal * 2.
	marshaling put: SmallInteger minVal * 2.
	marshaling put: 2 ** 256.
	marshaling put: -2 ** 256.
	self analyse.
	self assert: marshaling get = (SmallInteger maxVal * 2).
	self assert: marshaling get = (SmallInteger minVal * 2).
	self assert: marshaling get = (2 ** 256).
	self assert: marshaling get = (-2 ** 256)
!

testMissingClass
	| missingClass missingInstance object |
	missingClass := ObjectMarshaler basicNew
		resolveClass: 'fulluble'
		isMeta: false
		format: (Behavior formatFromType: #none super: Object instVars: #('a' 'b' 'c'))
		instVarNames: #('a' 'b' 'c').
	missingInstance := missingClass new.
	missingInstance instVarNamed: 'a' put: 1.
	missingInstance instVarNamed: 'b' put: 2.
	missingInstance instVarNamed: 'c' put: 3.
	marshaling put: missingInstance.
	self analyse.
	object := marshaling get.
	self assert: object class ~~ missingClass.
	self assert: object class superclass = Object.
	self assert: (object instVarNamed: 'a') = 1.
	self assert: (object instVarNamed: 'b') = 2.
	self assert: (object instVarNamed: 'c') = 3.
	self assert: object a = 1.
	self assert: object b = 2.
	self assert: object c = 3.
	object a: 4.
	object b: 5.
	object c: 6.
	self assert: object a = 4.
	self assert: object b = 5.
	self assert: object c = 6.
!

testNamespace
	marshaling put: Root.Smalltalk.
	marshaling put: Root.Smalltalk.Xtreams.
	self analyse.
	self assert: marshaling get = Root.Smalltalk.
	self assert: marshaling get = Root.Smalltalk.Xtreams
!

testOrderedCollection
	| result |
	marshaling put: (OrderedCollection new add: #test; add: 'test'; add: 5; yourself).
	self analyse.
	result := marshaling get.
	self assert: result first = #test.
	self assert: (result at: 2) = 'test'.
	self assert: result last = 5
!

testPoint
	marshaling put: -1 @ 2.
	marshaling put: 3.4 @ -4.5.
	marshaling put: 5 @ 5.
	self analyse.
	self assert: marshaling get = (-1 @ 2).
	self assert: marshaling get = (3.4 @ -4.5).
	self assert: marshaling get = (5 @ 5)
!

testRecursion
	| value result |
	value := nil asValue.
	value value: value.
	marshaling put: value.
	self analyse.
	result := marshaling get.
	self assert: result value == result
!

testSortedCollection
	| sortBlock result |
	sortBlock := Kernel.Compiler evaluate: '[:a :b | a <= b]'.
	marshaling put: ((SortedCollection sortBlock: sortBlock) add: 5; add: 4; add: 1; add: 3; add: 2; yourself).
	self analyse.
	result := marshaling get.
	self assert: result asArray = #(1 2 3 4 5).
	result add: 1.5.
	self assert: result asArray = #(1 1.5 2 3 4 5)
!

testString
	marshaling put: 'testing Ω'.
	self analyse.
	self assert: marshaling get = 'testing Ω'
!

testTranscript
	marshaling put: Transcript.
	marshaling put: (Array with: Transcript).
	self analyse.
	self assert: marshaling get == Transcript.
	self assert: marshaling get = (Array with: Transcript)
! !

!ObjectMarshalerTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:35:48 PM'                  !

"{ Package: 'stx:goodies/xtreams/transforms/tests' }"

LibraryDefinition subclass:#stx_goodies_xtreams_transforms_tests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_transforms_tests class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 20 2011-11-21 06:04:22Z mkobetic $'
! !

!stx_goodies_xtreams_transforms_tests class methodsFor:'description'!

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
        #'stx:goodies/sunit'    "TestAsserter - superclass of Xtreams::MessagePackMarshalerTest "
        #'stx:goodies/xtreams/core'    "Xtreams::Incomplete - referenced by Xtreams::ReadingWritingTest>>testReadTransformingPastEnd "
        #'stx:goodies/xtreams/core/tests'    "Xtreams::FiniteReadingWritingTests - superclass of extended Xtreams::CollectionReadingWritingTest "
        #'stx:goodies/xtreams/terminals/tests'    "Xtreams::CollectionReadingWritingTest - extended "
        #'stx:goodies/xtreams/transforms'    "Xtreams::ObjectAnalyseStream - referenced by Xtreams::ObjectMarshalerTest>>analyse "
        #'stx:libbasic'    "Object - superclass of Xtreams::MessagePackMarshalerTest "
        #'stx:libbasic2'    "Random - referenced by Xtreams::ReadingWritingTest>>testInterpretingPoints "
        #'stx:libcompat'    "IOAccessor - referenced by Xtreams::ReadingWritingTest>>testWriteEncodingCRLF "
    )
! !

!stx_goodies_xtreams_transforms_tests class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        (#'Xtreams::DuplicateTest' autoload)
        (#'Xtreams::InterpretingStreamTest' autoload)
        (#'Xtreams::MessagePackMarshalerTest' autoload)
        (#'Xtreams::ObjectMarshalerTest' autoload)
        #'stx_goodies_xtreams_transforms_tests'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        #'Xtreams::CollectionReadingWritingTest' testWriteTransformHexToByte
        #'Xtreams::FiniteReadingWritingTests' testInterpretingDoubles
        #'Xtreams::FiniteReadingWritingTests' testWriteTransformingOverLimitingPastEnd
        #'Xtreams::FiniteReadingWritingTests' testWriteTransformingPastEnd
        #'Xtreams::ReadingWritingTest' testCharacters
        #'Xtreams::ReadingWritingTest' testDoing
        #'Xtreams::ReadingWritingTest' testInterpretingPoints
        #'Xtreams::ReadingWritingTest' testMarshaling
        #'Xtreams::ReadingWritingTest' testReadCollecting
        #'Xtreams::ReadingWritingTest' testReadCollectingContentsSpeciesChanged
        #'Xtreams::ReadingWritingTest' testReadDecodingBase64
        #'Xtreams::ReadingWritingTest' testReadDecodingCRLF
        #'Xtreams::ReadingWritingTest' testReadDecodingTransparent
        #'Xtreams::ReadingWritingTest' testReadDecodingUTF16
        #'Xtreams::ReadingWritingTest' testReadDecodingUTF8
        #'Xtreams::ReadingWritingTest' testReadDuplicating
        #'Xtreams::ReadingWritingTest' testReadInjecting
        #'Xtreams::ReadingWritingTest' testReadRejecting
        #'Xtreams::ReadingWritingTest' testReadSelecting
        #'Xtreams::ReadingWritingTest' testReadTransforming1into2
        #'Xtreams::ReadingWritingTest' testReadTransforming2into1
        #'Xtreams::ReadingWritingTest' testReadTransformingPastEnd
        #'Xtreams::ReadingWritingTest' testReadUnsignedShortEndianness
        #'Xtreams::ReadingWritingTest' testWriteCollecting
        #'Xtreams::ReadingWritingTest' testWriteCollectingIncompatibleContentSpecies
        #'Xtreams::ReadingWritingTest' testWriteCollectingMultipleBufferSize
        #'Xtreams::ReadingWritingTest' testWriteDuplicating
        #'Xtreams::ReadingWritingTest' testWriteEncodingBase64
        #'Xtreams::ReadingWritingTest' testWriteEncodingCRLF
        #'Xtreams::ReadingWritingTest' testWriteEncodingTransparent
        #'Xtreams::ReadingWritingTest' testWriteEncodingUTF16
        #'Xtreams::ReadingWritingTest' testWriteEncodingUTF8
        #'Xtreams::ReadingWritingTest' testWriteInjecting
        #'Xtreams::ReadingWritingTest' testWriteRejecting
        #'Xtreams::ReadingWritingTest' testWriteSelecting
        #'Xtreams::ReadingWritingTest' testWriteTransformHexToByte
        #'Xtreams::ReadingWritingTest' testWriteTransforming1into2
        #'Xtreams::ReadingWritingTest' testWriteTransforming2into1
        #'Xtreams::ReadingWritingTest' testWriteUnsignedShortEndianness
        #'Xtreams::CollectionReadingWritingTest' testReadRejecting
        #'Xtreams::CollectionReadingWritingTest' testReadSelecting
        #'Xtreams::CollectionReadingWritingTest' testWriteRejecting
        #'Xtreams::CollectionReadingWritingTest' testWriteSelecting
    )
! !

!stx_goodies_xtreams_transforms_tests class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_transforms_tests class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/transforms/tests/stx_goodies_xtreams_transforms_tests.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'29'"$"
! !

!stx_goodies_xtreams_transforms_tests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_transforms_tests.st 20 2011-11-21 06:04:22Z mkobetic $'
! !
!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testReadRejecting
        self output write: #[ 1 2 3 4 5 6 7 8 9 ].
        self assert: ((self input rejecting: [ :e | e even ]) read: 5) = #[ 1 3 5 7 9 ]
! !

!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testReadSelecting
        self output write: #[ 1 2 3 4 5 6 7 8 9 ].
        self assert: ((self input selecting: [ :e | e even ]) read: 4) = #[ 2 4 6 8 ]
! !

!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testWriteRejecting
        (self output rejecting: [ :e | e even ] ) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
        self assert: (self input read: 5) = #[ 1 3 5 7 9 ]
! !

!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testWriteSelecting
        (self output selecting: [ :e | e even]) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
        self assert: (self input read: 4) = #[ 2 4 6 8 ]
! !

!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testWriteTransformHexToByte
	| hex2Byte decoder result |
	decoder := [ :char | ('0123456789ABCDEF' indexOf: char asUppercase) - 1 ].
	hex2Byte := 
		self output transforming: [ :in :out |
			out put: (((decoder value: in get) bitShift: 4) + (decoder value: in get)) ].
	hex2Byte buffer: (ElasticBuffer on: (ByteString new: 16)).
	hex2Byte write: 'ab'.
	hex2Byte write: 'cdef'.
	hex2Byte close.
	self assert: self input get = 16rAB.
	result := self input read: 2.
	self assert: result = #[16rcd 16ref].
! !

!FiniteReadingWritingTests methodsFor:'tests - interpreting'!

testInterpretingDoubles
	| doubles result |
	doubles := (1 to: 10) reading collect: [ :i | i reciprocal asDouble ].
	(self output interpreting: #double) write: doubles; close.
	result := (self input interpreting: #double) rest.
	self assert: result = doubles
! !

!FiniteReadingWritingTests methodsFor:'tests - transforming'!

testWriteTransformingOverLimitingPastEnd

	| limited transferred |
	limited := (self output limiting: 10) transforming: [ :in :out | out put: in get ].
	self assert: (
		[	limited write: (ByteArray withAll: (1 to: 20)).
			false
		] on: Incomplete do: [ :ex | ex count = 11 ] ).
	transferred := self input read: 10.
	self assert: transferred = (ByteArray withAll: (1 to: 10))
! !

!FiniteReadingWritingTests methodsFor:'tests - transforming'!

testWriteTransformingPastEnd
	| count transformed |
	count := 1.
	transformed := self output transforming: [:in :out |
		count = 2 ifTrue: [Incomplete zero raise].
		out put: in get.
		count := count + 1].
	self assert: (
		[	transformed write: #[ 1 2 3 ].
			false
		] on: Incomplete do: [ :ex | ex count = 1 ]).
	transformed close.
	self assert: self input get = 1.
	self should: [self input get] raise: Incomplete.
	self should: [self input get] raise: Incomplete
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testDoing
	| outing inning |
	outing := ByteArray new writing.
	(self output doing: [:each | outing put: each]) write: #[ 1 2 3 4 5 ].
	self assert: outing contents = #[ 1 2 3 4 5 ].

	inning := ByteArray new writing.
	self assert: ((self input doing: [:each | inning put: each]) read: 5) = #[ 1 2 3 4 5 ].
	self assert: inning contents = #[ 1 2 3 4 5 ]
! !

!ReadingWritingTest methodsFor:'tests - interpreting'!

testInterpretingPoints

	| points result |
	points := (Random new reading transforming: [ :in :out | out put: in get @ in get ]) read: 5.
	(self output interpreting: [ :b :i :o | b doubleAt: i put: o x. b doubleAt: i + 8 put: o y ] size: 16 )
		write: points;
		close.
	result := (self input interpreting: [ :b :i | (b doubleAt: i) @ (b doubleAt: i + 8) ] size: 16 cacheSize: 5) read: points size.
	self assert: points = result
! !

!ReadingWritingTest methodsFor:'tests - interpreting'!

testMarshaling
	| object result in out |
	object := Object new.
	out := self output marshaling.
	in := self input marshaling.
	2 timesRepeat: 
		[out put: ((1 to: 11) collect: [:each | (1 to: 11) collect: [:ea | object]]).
		result := in get.
		self assert: result size = 11.
		self assert: (result allSatisfy: [:each | each allSatisfy: [:ea | ea == result first first]])]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadCollecting
	| data |
	data := #[ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ].
	self output write: data.
	self assert: ((self input collecting: [:e | e * e]) read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadCollectingContentsSpeciesChanged
	| data result |
	data := ByteArray withAll: ((1 to: 16) collect: [:index | 65]).
	self output write: data.
	result :=
		(self input collecting: [:e | Character codePoint: e])
			contentsSpecies: String;
			read: data size.
	self assert: result = (String withAll: (data asArray collect: [:e | Character codePoint: e]))
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testReadDecodingBase64
	(self output encoding: #ascii)
		write: 
'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlz
IHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2Yg
dGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGlu
dWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRo
ZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=';
		close.
	self assert: (((self input encoding: #ascii) encodingBase64 encoding: #ascii) read: 269) = 'Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.'
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testReadDecodingCRLF

	| result |
	self output write: #[104 101 108 108 111 13 10 119 111 114 108 100 10 13 13 10 10 ]; close.
	result := (self input encoding: #ascii) read: 15.
	self assert: result = 'hello\world\\\\' withCRs
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testReadDecodingTransparent

	| result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	self output write: bytes; close.
	result := (self input encoding: #ascii) setLineEndTransparent read: bytes size.
	self assert: result = (String withAll: (bytes asArray collect: #asCharacter))
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testReadDecodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	self output write: bytes; close.
	result := (self input encoding: #utf16) read: 12.
	self assert: result = 'Hello World!!'
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testReadDecodingUTF8

	| result bytes text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	bytes := #[80 197 153 195 173 108 105 197 161 32 197 190 108 117 197 165 111 117 196 141 107 195 189 32 107 197 175 197 136 32 195 186 112 196 155 108 32 196 143 195 161 98 101 108 115 107 195 169 32 195 179 100 121].
	self output write: bytes; close.
	result := (self input encoding: #utf8) read: text size.
	self assert: result = text
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadDuplicating

	| copy contents |
	contents := Array withAll: (0 to: 15).
	copy := Array new writing.
	self assert: (contents reading duplicating: copy) rest = contents.
	self assert: copy conclusion = contents
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadInjecting
	self output write: #[ 1 2 3 4 ].
	self assert: ((self input injecting: 0 into: [:all :each | all + each]) read: 4) = #[ 1 3 6 10 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadRejecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input rejecting: #even) read: 5) = #[ 1 3 5 7 9 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadSelecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input selecting: #even) read: 4) = #[ 2 4 6 8 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadTransforming1into2
	| result |
	self output write: #[ 1 2 3 ].
	result :=
		(self input transforming: [:in :out | | x | x := in get. out put: x; put: x])
			read: 6.
	self assert: result = #[ 1 1 2 2 3 3 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadTransforming2into1
	| result |
	self output write: #[ 1 2 3 4 ].
	result :=
		(self input transforming: [:in :out | in get. out put: in get])
			read: 2.
	self assert: result = #[ 2 4 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testReadTransformingPastEnd
	| count transformed |
	count := 1.
	self output write: #[ 1 2 3 ]; close.
	transformed := self input transforming: [:in :out |
		count = 2 ifTrue: [Incomplete zero raise].
		out put: in get.
		count := count + 1].
	self assert: transformed get = 1.
	self should: [transformed get] raise: Incomplete.
	self should: [transformed get] raise: Incomplete
! !

!ReadingWritingTest methodsFor:'tests - interpreting'!

testReadUnsignedShortEndianness

	self output write: #[ 16rFF 16r00 16rFF 00]; close.
	self assert: (self input interpreting: #unsignedShort_le) get = 16rFF.
	self assert: (self input interpreting: #unsignedShort_be) get = 16rFF00.
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteCollecting
	| data |
	data := 1 to: 15.
	(self output collecting: [:e | e * e]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteCollectingIncompatibleContentSpecies
	| data |
	data := (1 to: 15) collect: [ :x | x @ 0 ].
	(self output collecting: [:e | e x ]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e x]))
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteCollectingMultipleBufferSize
	| data |
	data := (1 to: DefaultBufferSize + 500) collect: [ :i | i \\ 16 ].
	self timeout: 1 seconds
		server:
			[(self output collecting: [:e | e * e])
				write: data;
				close.
			true]
		client: [(self input read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteDuplicating

	| original copy contents |
	contents := Array withAll: (0 to: 15).
	original := Array new writing.
	copy := Array new writing.
	(original duplicating: copy) write: contents.
	self assert: original conclusion = contents.
	self assert: copy conclusion = contents
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testWriteEncodingBase64
	((self output encoding: #ascii) encodingBase64 encoding: #ascii)
		write: 'Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.';
		close.
	self assert: ((self input encoding: #ascii) read: 360) = 'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4='
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testWriteEncodingCRLF

	| result isCRLF |
	(self output encoding: #ascii)
		write: 'hello\world\\\' withCRs;
		close.
	isCRLF := IOAccessor defaultClass = PCIOAccessor.
	result := self input read: (isCRLF ifTrue: [18] ifFalse: [14]).
	
	self assert: result = (isCRLF
		ifTrue: [#[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ] ]
		ifFalse: [#[104 101 108 108 111 10 119 111 114 108 100 10 10 10 ] ])
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testWriteEncodingTransparent

	| data result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	data := String withAll: (bytes asArray collect: #asCharacter).
	(self output encoding: #ascii)
		setLineEndTransparent;
		write: data;
		close.
	result := self input read: data size.
	self assert: result = bytes
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testWriteEncodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	(self output encoding: #utf16) write: 'Hello World!!'; close.
	result := self input read: 24.
	self assert: result = bytes
! !

!ReadingWritingTest methodsFor:'tests - encoding'!

testWriteEncodingUTF8

	| result bytes text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	bytes := #[80 197 153 195 173 108 105 197 161 32 197 190 108 117 197 165 111 117 196 141 107 195 189 32 107 197 175 197 136 32 195 186 112 196 155 108 32 196 143 195 161 98 101 108 115 107 195 169 32 195 179 100 121].
	(self output encoding: #utf8) write: text; close.
	result := self input read: bytes size.
	self assert: result = bytes
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteInjecting
	(self output injecting: 0 into: [:all :each | all + each])
		write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 4) = #[ 1 3 6 10 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteRejecting
	(self output rejecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 5) = #[ 1 3 5 7 9 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteSelecting
	(self output selecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 4) = #[ 2 4 6 8 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteTransformHexToByte
	| hex2Byte decoder result |
	decoder := [ :char | ('0123456789ABCDEF' indexOf: char asUppercase) - 1 ].
	hex2Byte := 
		self output transforming: [ :in :out |
			out put: (((decoder value: in get) bitShift: 4) + (decoder value: in get)) ].
	hex2Byte buffer: (ElasticBuffer on: (ByteString new: 16)).
	hex2Byte write: 'ab'.
	self assert: self input get = 16rAB.
	hex2Byte write: 'cdef'.
	hex2Byte close.
	result := self input read: 2.
	self assert: result = #[16rcd 16ref].
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteTransforming1into2
	| result |
	(self output transforming: [:in :out | | x | x := in get. out put: x; put: x])
		write: #[ 1 2 3 ];
		close.
	result := (self input read: 6).
	self assert: result = #[ 1 1 2 2 3 3 ]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testWriteTransforming2into1
	| result |
	(self output transforming: [:in :out | in get. out put: in get])
		write: #[ 1 2 3 4 ];
		close.
	result := self input read: 2.
	self assert: result = #[ 2 4 ]
! !

!ReadingWritingTest methodsFor:'tests - interpreting'!

testWriteUnsignedShortEndianness

	(self output interpreting: #unsignedShort_le) put: 16rFF.
	(self output interpreting: #unsignedShort_be) put: 16rFF00.
	self output close.
	self assert: (self input read: 4) = #[ 16rFF 16r00 16rFF 00]
! !

