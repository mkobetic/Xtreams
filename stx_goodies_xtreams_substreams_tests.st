'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:19 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#StitchingTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Substreams-Tests'
!


!StitchingTest methodsFor:'tests'!

test2SimpleReadStreams

	| stream contents |
	stream := (1 to: 5) reading, (6 to: 7) reading.
	contents := stream rest.
	self assert: contents = (1 to: 7)
!

test3SimpleReadStreams

	| stream contents |
	stream := (1 to: 5) reading, (6 to: 7) reading, (8 to: 10) reading.
	contents := stream rest.
	self assert: contents = (1 to: 10)
!

test3SimpleReadStreamsPrepending

	| stream contents |
	stream := (1 to: 5) reading, ((6 to: 7) reading, (8 to: 10) reading).
	contents := stream rest.
	self assert: contents = (1 to: 10)
! !

!StitchingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__StitchingTest.st 69 2012-01-30 22:21:28Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 30-01-2012 at 10:58:19 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams/tests' }"

LibraryDefinition subclass:#stx_goodies_xtreams_substreams_tests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_substreams_tests class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 69 2012-01-30 22:21:28Z mkobetic $'
! !

!stx_goodies_xtreams_substreams_tests class methodsFor:'description'!

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
        #'stx:goodies/sunit'    "TestCase - superclass of Xtreams::StitchingTest "
        #'stx:goodies/xtreams/core'    "Xtreams::RingBuffer - referenced by Xtreams::FiniteReadingWritingTests>>testWriteStitchingChunks "
        #'stx:goodies/xtreams/core/tests'    "Xtreams::ReadingWritingTest - superclass of extended Xtreams::FiniteReadingWritingTests "
        #'stx:goodies/xtreams/substreams'
        #'stx:libbasic'    "ProjectDefinition - superclass of stx_goodies_xtreams_substreams_tests "
    )
! !

!stx_goodies_xtreams_substreams_tests class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        (#'Xtreams::StitchingTest')
        #'stx_goodies_xtreams_substreams_tests'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        #'Xtreams::FiniteReadingWritingTests' testReadClosing
        #'Xtreams::FiniteReadingWritingTests' testReadEndingBlock
        #'Xtreams::FiniteReadingWritingTests' testReadEndingBlockPositioning
        #'Xtreams::FiniteReadingWritingTests' testReadEndingBlockTail
        #'Xtreams::FiniteReadingWritingTests' testReadEndingCollection
        #'Xtreams::FiniteReadingWritingTests' testReadEndingCollectionPositioning
        #'Xtreams::FiniteReadingWritingTests' testReadEndingCollectionTail
        #'Xtreams::FiniteReadingWritingTests' testReadEndingObject
        #'Xtreams::FiniteReadingWritingTests' testReadEndingObjectPositioning
        #'Xtreams::FiniteReadingWritingTests' testReadEndingObjectTail
        #'Xtreams::FiniteReadingWritingTests' testReadLimiting
        #'Xtreams::FiniteReadingWritingTests' testReadLimitingPositioning
        #'Xtreams::FiniteReadingWritingTests' testReadStitchLimiting
        #'Xtreams::FiniteReadingWritingTests' testReadStitchingChunks
        #'Xtreams::FiniteReadingWritingTests' testWriteClosing
        #'Xtreams::FiniteReadingWritingTests' testWriteClosingPositioning
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingBlock
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingBlockTail
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingCollection
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingCollectionTail
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingObject
        #'Xtreams::FiniteReadingWritingTests' testWriteEndingObjectTail
        #'Xtreams::FiniteReadingWritingTests' testWriteLimiting
        #'Xtreams::FiniteReadingWritingTests' testWriteLimitingPositioning
        #'Xtreams::FiniteReadingWritingTests' testWriteStitchLimiting
        #'Xtreams::FiniteReadingWritingTests' testWriteStitchingChunks
    )
! !

!stx_goodies_xtreams_substreams_tests class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_substreams_tests class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/substreams/tests/stx_goodies_xtreams_substreams_tests.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'24'"$"
! !

!stx_goodies_xtreams_substreams_tests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_substreams_tests.st 15 2011-11-21 06:02:13Z mkobetic $'
! !
!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadClosing
	| closing closed |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	closed := 0.
	closing := (self input closing: [ closed := closed + 1 ]) slicing.

	self assert: (closing get read: 3) = #[ 1 2 3 ].
	self assert: (closing get read: 4) = #[ 4 5 6 7 ].
	self assert: closed = 1.
	self assert: (closing get read: 2) = #[ 8 9 ].
	self assert: closed = 2.
	self should: [closing get get] raise: Incomplete.
	self assert: closed = 3.
	self should: [closing get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingBlock
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: [:e | e = 4]) slicing.
	substream := ender get.
	self assert: (substream read: 3) = #[ 1 2 3 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingBlockPositioning
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: [:e | e = 4]) slicing.
	substream := ender get.
	substream ++ 2.
	self assert: substream get = 3.
	self should: [substream ++ 3] raise: Incomplete.
	self should: [substream -- 2] raise: Error. "not positionable"
	substream := ender get.
	self assert: substream get = 5.
	substream -= 0.
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingBlockTail
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: [:e | e = 4] inclusive: true) slicing.
	substream := ender get.
	self assert: (substream read: 4) = #[ 1 2 3 4 ].
	self should: [substream get] raise: Incomplete.
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingCollection
	| substream ender |
	self output write: #[ 0 1 1 2 1 2 3 4 5 6 ]; close.
	ender := (self input ending: #[ 1 2 3 ]) slicing.
	substream := ender get.
	self assert: (substream read: 4) = #[ 0 1 1 2 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 3) = #[ 4 5 6 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingCollectionPositioning
	| substream ender |
	self output write: #[ 0 1 1 2 1 2 3 4 5 6 ]; close.
	ender := (self input ending: #[ 1 2 3 ]) slicing.
	substream := ender get.
	substream ++ 3.
	self assert: substream get = 2.
	self should: [substream ++ 3] raise: Incomplete.
	self should: [substream -- 2] raise: Error. "not positionable"
	substream := ender get.
	self assert: substream get = 4.
	substream -= 0.
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingCollectionTail
	| substream ender |
	self output write: #[ 0 1 1 2 1 2 3 4 5 6 ]; close.
	ender := (self input ending: #[ 1 2 3 ] inclusive: true) slicing.
	substream := ender get.
	self assert: (substream read: 7) = #[ 0 1 1 2 1 2 3 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 3) = #[ 4 5 6 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingObject
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: 4) slicing.
	substream := ender get.
	self assert: (substream read: 3) = #[ 1 2 3 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingObjectPositioning
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: 4) slicing.
	substream := ender get.
	substream ++ 2.
	self assert: substream get = 3.
	self should: [substream ++ 3] raise: Incomplete.
	self should: [substream -- 2] raise: Error. "not positionable"
	substream := ender get.
	self assert: substream get = 5.
	substream -= 0.
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadEndingObjectTail
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: 4 inclusive: true) slicing.
	substream := ender get.
	self assert: (substream read: 4) = #[ 1 2 3 4 ].
	self should: [substream get] raise: Incomplete.
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadLimiting
	| subinput limiter |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	limiter := (self input limiting: 3) slicing.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 1 1 1 ].
	self should: [subinput get] raise: Incomplete.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 2 2 2 ].
	self should: [subinput get] raise: Incomplete.

	self should: [limiter get get] raise: Incomplete.
	self should: [limiter get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testReadLimitingPositioning
	| subinput limiter |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	limiter := (self input limiting: 3) slicing.

	subinput := limiter get.
	subinput ++ 2.
	self assert: subinput rest = #[ 1 ].
	subinput isPositionable
		ifTrue: [ subinput -- 2.
			self assert: subinput rest = #[ 1 1 ].
			subinput += 1.
			self assert: subinput rest = #[ 1 1 ].
			subinput -= 2.
			self assert: subinput rest = #[ 1 1 ] ]
		ifFalse: [ self should: [ subinput -- 2 ] raise: Error ].
	self should: [subinput get] raise: Incomplete.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 2 2 2 ].
	self should: [subinput get] raise: Incomplete.

	self should: [limiter get get] raise: Incomplete.
	self should: [limiter get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream stitching'!

testReadStitchLimiting
"Note that a plain [ self input limiting: 3 ] reading stitching stream would never end because it keeps generating empty limiting: streams at the end of the input.
That's why additional measure is necessary to make sure the slice source eventually generates Incomplete.
" 
	| limiter wasEmpty |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	wasEmpty := false.
	limiter := [
			wasEmpty ifTrue: [ Incomplete zero raise ]. wasEmpty := true.
			(self input doing: [ :e | wasEmpty := false ]) limiting: 3
		] reading stitching.

	self assert: limiter rest = #[ 1 1 1 2 2 2].
	self should: [limiter get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream stitching'!

testReadStitchingChunks
"Chunks are prefixed with size in the first byte. Below we have 3 chunks of size 1, 3 and 7, and terminating 0 chunk."

	| chunks contents stitched |
	chunks := (ByteArray withAll: (1 to: 14)), #[0].
	self output write: chunks; close.
	stitched := [ self input limiting: self input get ] reading stitching.
	contents := stitched rest.
	self assert: contents = #[2 4 5 6 8 9 10 11 12 13 14]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteClosing
	| closing suboutput |
	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 1 1 ]; close.

	suboutput := closing get.
	suboutput write: #[ 2 2 2 ]; close.
	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteClosingPositioning
	| closing suboutput |

	"If we're on a non-positionable stream, there's no point trying to test substream positioning"
	self output isPositionable ifFalse: [^self].

	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 3 3 ].
	self assert: suboutput position = 3.
	suboutput -- 2.
	self assert: suboutput position = 1.
	suboutput write: #[ 1 1 ]; close.

	suboutput := closing get.
	suboutput write: #[ 2 2 3 ].
	suboutput += 1.
	self assert: suboutput position = 1.
	suboutput ++ 1.
	suboutput put: 2; close.

	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingBlock
	| ender |
	ender := (self output ending: [:e | e = 4]) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingBlockTail
	| ender |
	ender := (self output ending: [:e | e = 4] inclusive: true) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingCollection
	| ender |
	ender := (self output ending: #[ 1 2 3 ]) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 7) = #[ 0 1 1 2 4 5 6 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingCollectionTail
	| ender |
	ender := (self output ending: #[ 1 2 3 ] inclusive: true) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 10) = #[ 0 1 1 2 1 2 3 4 5 6 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingObject
	| ender |
	ender := (self output ending: 4) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteEndingObjectTail
	| ender |
	ender := (self output ending: 4 inclusive: true) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteLimiting
	| limiting suboutput |
	limiting := (self output limiting: 3) slicing.

	suboutput := limiting get.
	suboutput write: #[ 1 1 1 ].
	self should: [suboutput put: 1] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 2 2 2 ].
	self should: [suboutput put: 2] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 3 3 3 ].
	self should: [suboutput put: 3] raise: Incomplete.

	limiting close.
	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream slicing'!

testWriteLimitingPositioning
	| limiting suboutput |

	"If we're not on a positioning stream, there's no point testing substream positioning"
	self output isPositionable ifFalse: [^self].

	limiting := (self output limiting: 3) slicing.

	suboutput := limiting get.
	suboutput write: #[ 1 4 4 ].
	self assert: suboutput position = 3.
	self assert: suboutput length = 3.
	self assert: suboutput available = 0.
	suboutput -- 2.
	self assert: suboutput position = 1.
	self assert: suboutput length = 3.
	self assert: suboutput available = 2.
	suboutput write: #[ 1 1 ].
	self should: [suboutput put: 1] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 2 2 3 ].
	suboutput += 1.
	self assert: suboutput position = 1.
	self assert: suboutput length = 3.
	self assert: suboutput available = 2.
	suboutput ++ 1.
	self assert: suboutput position = 2.
	self assert: suboutput length = 3.
	self assert: suboutput available = 1.
	suboutput put: 2.
	self should: [suboutput put: 2] raise: Incomplete.

	limiting close.
	self assert: (self input read: 6) = #[ 1 1 1 2 2 2 ]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream stitching'!

testWriteStitchLimiting
	| limiting |
	limiting := [self output limiting: 3] reading stitching.

	limiting write: #[ 1 1 1 2 2 2 3 3 3 ].
	limiting close.

	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]
! !

!FiniteReadingWritingTests methodsFor:'tests - substream stitching'!

testWriteStitchingChunks
"Chunks are prefixed with size in the first byte. Below we have 3 chunks of size 1, 3 and 7, and terminating 0 chunk."

	| contents buffer |
	buffer := RingBuffer on: (ByteArray new: 3).
	[	(buffer writing limiting: buffer cacheSize)
			closeBlock: [ self output put: buffer readSize; write: buffer ];
			yourself
	] reading stitching
		write: (1 to: 7); flush;
		write: (8 to: 15); close.
	self output close.
	contents := self input rest.
	self assert: contents =
		#[	3 1 2 3 "first chunk"
			3 4 5 6 "second chunk"
			1 7		"short chunk after flush"
			3 8 9 10 "full chunk"
			3 11 12 13 "full chunk"
			2 14 15	"final short chunk" ]
! !

