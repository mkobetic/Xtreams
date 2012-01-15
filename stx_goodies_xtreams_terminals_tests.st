'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#PipeReadingWritingTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals-Tests'
!


!PipeReadingWritingTest methodsFor:'initialize-release'!

setUp
	| pipe |
	(OSHandle currentOS = #win32) ifTrue: [self error: 'Does not work on Windows' ].
	pipe := OSSystemSupport concreteClass pipeAccessorClass openPair.
	input := pipe first reading.
	output := pipe last writing.
!

tearDown
	input close.
	output close.
! !

!PipeReadingWritingTest methodsFor:'utilities'!

timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	|	timeout
		serverSuccess serverProcess serverLock
		clientSuccess clientProcess clientLock|

	timeout := false.
	serverLock := Semaphore new.
	clientLock := Semaphore new.
	serverSuccess := clientSuccess := false.
	serverProcess := [serverSuccess := serverBlock value. serverLock signal] fork.
	clientProcess := [clientSuccess := clientBlock value. clientLock signal] fork.

	Core.Timer after: timeoutDuration do:
		[serverProcess terminate.
		output ifNotNil: [ output close ].
		clientProcess terminate.
		input ifNotNil: [ input close ].
		timeout := true.
		serverLock signal.
		clientLock signal].
	serverLock wait.
	clientLock wait.

	self assert: serverSuccess.
	self assert: clientSuccess.
	self deny: timeout
! !

!PipeReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

LibraryDefinition subclass:#stx_goodies_xtreams_terminals_tests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!


!stx_goodies_xtreams_terminals_tests class methodsFor:'description'!

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
        #'stx:goodies/sunit'    "TestAsserter - superclass of Xtreams::BlockClosureTest "
        #'stx:goodies/xtreams/core'    "Xtreams::Incomplete - referenced by Xtreams::CollectionReadingWritingTest>>testWriteFromStream "
        #'stx:goodies/xtreams/core/tests'    "Xtreams::ReadingWritingTest - superclass of Xtreams::SharedQueueReadingWritingTest "
        #'stx:libbasic'    "Object - superclass of Xtreams::BlockClosureTest "
        #'stx:libbasic2'    "Socket - referenced by Xtreams::SocketReadingWritingTest>>setUp "
    )
! !

!stx_goodies_xtreams_terminals_tests class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        #'stx_goodies_xtreams_terminals_tests'
        (#'Xtreams::BlockClosureReadingWritingTest' autoload)
        (#'Xtreams::BlockClosureTest' autoload)
        (#'Xtreams::BufferReadingWritingTest' autoload)
        (#'Xtreams::BufferedWriteStreamTest' autoload)
        (#'Xtreams::CollectionReadingWritingTest' autoload)
        (#'Xtreams::ElasticBufferReadingWritingTest' autoload)
        (#'Xtreams::FileReadingWritingTest' autoload)
        (#'Xtreams::PipeReadingWritingTest' autoload)
        (#'Xtreams::PointerReadStreamTest' autoload)
        (#'Xtreams::PointerReadingWritingTest' autoload)
        (#'Xtreams::PointerWriteStreamTest' autoload)
        (#'Xtreams::RingBufferReadingWritingTest' autoload)
        (#'Xtreams::SharedQueueReadingWritingTest' autoload)
        (#'Xtreams::SocketReadingWritingTest' autoload)
        #'Xtreams::stx_goodies_xtreams_terminals_tests'
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
    )
! !

!stx_goodies_xtreams_terminals_tests class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_terminals_tests class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/terminals/tests/stx_goodies_xtreams_terminals_tests.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'27'"$"
! !

!stx_goodies_xtreams_terminals_tests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_terminals_tests.st 18 2011-11-21 06:03:36Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#RingBufferReadingWritingTest
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!RingBufferReadingWritingTest methodsFor:'initialize-release'!

setUp

	buffer := RingBuffer on: (ByteArray new: 8192).
	input := buffer reading.
	output := buffer writing.
! !

!RingBufferReadingWritingTest methodsFor:'tests - core'!

testReadWriteLargeAmount
	
	"does not work on limited size ring buffer"
! !

!RingBufferReadingWritingTest methodsFor:'tests - transforming'!

testWriteCollectingMultipleBufferSize

	"does not work on limited size ring buffer"
! !

!RingBufferReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#BlockClosureTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!BlockClosureTest methodsFor:'tests'!

testOneArgumentReading
	self assert:
		([:out | 1 to: 10 do: [:i | out put: i]] reading
			contentsSpecies: ByteArray;
			read: 5) = #[ 1 2 3 4 5 ]
! !

!BlockClosureTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#ElasticBufferReadingWritingTest
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!ElasticBufferReadingWritingTest methodsFor:'initialize-release'!

setUp

	buffer := ElasticBuffer on: ByteArray new.
	input := buffer reading.
	output := buffer writing.
! !

!ElasticBufferReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#BlockClosureReadingWritingTest
	instanceVariableNames:'collection'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!BlockClosureReadingWritingTest methodsFor:'initialize-release'!

setUp

	collection := OrderedCollection new.
	input := [ collection isEmpty ifTrue: [ Incomplete zero raise ]. collection removeFirst ] reading.
	input contentsSpecies: ByteArray.
	output := [ :x | collection addLast: x ] writing.
	output contentsSpecies: ByteArray.
! !

!BlockClosureReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#BufferReadingWritingTest
	instanceVariableNames:'buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!BufferReadingWritingTest methodsFor:'initialize-release'!

setUp

	buffer := Buffer on: ByteArray new.
	input := buffer reading.
	output := buffer writing.
! !

!BufferReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#CollectionReadingWritingTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!CollectionReadingWritingTest methodsFor:'initialize-release'!

input

	^input ifNil: [ input := (self output close; terminal) reading ]
!

output

	^output ifNil: [ output := ByteArray new writing ]
! !

!CollectionReadingWritingTest methodsFor:'tests - core'!

testInsert
	self output write: #[ 1 2 3 4 7 8 9 0 ].
	self output -- 4.
	self output insert: #[ 5 6 ].
	self output -= 0. "Have to seek to the end otherwise output gets truncated when we close it"
	self assert: (self input read: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ]
!

testReadWriteLargeAmount
        | data |
    1 to: 10 do: [:each | 
        output := input := nil.
        self output put: 1. self assert: self input get = 1].
       #( 64 1024 2048 4096 8192 ) do: [:dataSize |
                output := input := nil.
                data := ByteArray new: dataSize.
                1 to: data size do: [:i | data at: i put: (i - 1) \\ 256].
                self    timeout:        1000 milliseconds
                        server:         [1 to: 10 do: [:each | self output write: data]. true]
                        client:         [(1 to: 10) inject: true into: [:pass :each | pass and: [(self input read: data size) = data]]]]
!

testWriteFromCollectionAt

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: 4 from: data at: 1) = 4.
	self assert: (self output write: 3 from: data at: 5) = 3.
	self assert: (self input read: 4) = (data first: 4).
	self assert: (self input read: 3) = (data last: 3)
!

testWriteFromStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: 3 from: data) = 3.
	self assert: (self output write: 1 from: data) = 1.
	self assert: (self input read: 3) = #[ 1 2 3 ].
	self assert: self input get = 4.
	self assert: (
		[	self output write: 2 from: data. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ])
! !

!CollectionReadingWritingTest methodsFor:'tests - transforming'!

testReadRejecting
        self output write: #[ 1 2 3 4 5 6 7 8 9 ].
        self assert: ((self input rejecting: [ :e | e even ]) read: 5) = #[ 1 3 5 7 9 ]
!

testReadSelecting
        self output write: #[ 1 2 3 4 5 6 7 8 9 ].
        self assert: ((self input selecting: [ :e | e even ]) read: 4) = #[ 2 4 6 8 ]
!

testWriteRejecting
        (self output rejecting: [ :e | e even ] ) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
        self assert: (self input read: 5) = #[ 1 3 5 7 9 ]
!

testWriteSelecting
        (self output selecting: [ :e | e even]) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
        self assert: (self input read: 4) = #[ 2 4 6 8 ]
!

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

!CollectionReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#FileReadingWritingTest
	instanceVariableNames:'file'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals-Tests'
!


!FileReadingWritingTest methodsFor:'initialize-release'!

setUp

	file := '<1s>-<2s>' expandMacrosWith: self class name with: testSelector.
	file :=
		(OSHandle currentOS = #unix and: [ '/dev/shm' asFilename exists ])
			ifTrue: [ ('/dev/shm/', file) asFilename ]
			ifFalse: [ file asFilename ].
	output := file writing.
	input := file reading.
!

tearDown

	input close.
	output close.
	file delete
! !

!FileReadingWritingTest methodsFor:'tests - core'!

testInsert
	"Do nothing, since files are not expected to implement insert:* "
! !

!FileReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

FiniteReadingWritingTests subclass:#SocketReadingWritingTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Terminals-Tests'
!


!SocketReadingWritingTest methodsFor:'initialize-release'!

setUp

        |listener|

        listener := Socket newTCP: 0.
        [   [   listener listenFor: 1.
                input := Socket newTCPclientToHost: #[127 0 0 1] port: listener port.
                output := listener accept
            ] ifCurtailed: [
                input notNil ifTrue: [ input close ].
                output notNil ifTrue: [ output close ] ].
        ] ensure: [ listener close ].
        input := input reading.
        output := output writing.
! !

!SocketReadingWritingTest methodsFor:'utilities'!

timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	|	timeout
		serverSuccess serverProcess serverLock
		clientSuccess clientProcess clientLock|

	timeout := false.
	serverLock := Semaphore new.
	clientLock := Semaphore new.
	serverSuccess := clientSuccess := false.
	serverProcess := [serverSuccess := serverBlock value. serverLock signal] fork.
	clientProcess := [clientSuccess := clientBlock value. clientLock signal] fork.

	Core.Timer after: timeoutDuration do:
		[serverProcess terminate.
		output ifNotNil: [ output close ].
		clientProcess terminate.
		input ifNotNil: [ input close ].
		timeout := true.
		serverLock signal.
		clientLock signal].
	serverLock wait.
	clientLock wait.

	self assert: serverSuccess.
	self assert: clientSuccess.
	self deny: timeout
! !

!SocketReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

InfiniteReadingWritingTests subclass:#SharedQueueReadingWritingTest
	instanceVariableNames:'queue'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!SharedQueueReadingWritingTest methodsFor:'initialize-release'!

setUp

	queue := SharedQueue new.
	(input := queue reading) contentsSpecies: ByteArray.
	(output := queue writing) contentsSpecies: ByteArray
! !

!SharedQueueReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:28 PM'                  !

"{ Package: 'stx:goodies/xtreams/terminals/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#BufferedWriteStreamTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Terminals-Tests'
!


!BufferedWriteStreamTest methodsFor:'tests'!

testBuffered
	| writing |
	writing := ByteArray new writing buffering: 10.
	writing write: #[ 1 2 3 4 5 ].
	self deny: (writing terminal first: 5) = #[ 1 2 3 4 5 ].
	writing write: #[ 6 7 8 9 ].
	self deny: (writing terminal first: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	writing put: 0.
	self deny: (writing terminal first: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ].
	writing write: #[ 11 12 ].
	self assert: (writing terminal first: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ].
	self deny: (writing terminal first: 12) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 ].
	writing flush.
	self assert: (writing terminal first: 12) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 ].
	writing write: #[ 13 14 ].
	self deny: (writing terminal first: 14) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 13 14 ].
	writing close.
	self assert: (writing terminal first: 14) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 13 14 ].
! !

!BufferedWriteStreamTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id$'
! !
