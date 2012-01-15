'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#ReadingWritingTest
	instanceVariableNames:'output input'
	classVariableNames:''
	poolDictionaries:'XtreamsPool'
	category:'Xtreams-Core-Tests'
!

ReadingWritingTest comment:'Tests in this hierarchy have to be written so that they run with all kinds of terminals. Consequently they generally need to do all their writing first and then reading, so that we can run against collection streams without the assumption that the collection preserves identity as it''s being grown by the write stream. Also the streams should be accessed via accessors for the same reasons.

Instance Variables
	output  <Object> undocumented
	input   <Object> undocumented

'
!


!ReadingWritingTest class methodsFor:'testing'!

isAbstract
    "Override to true if a TestCase subclass is Abstract and should not have
     TestCase instances built from it"
    
    ^ self subclasses notEmpty
! !

!ReadingWritingTest methodsFor:'accessing'!

input

	^input
!

output

	^output
! !

!ReadingWritingTest methodsFor:'tests - core'!

testInsert
	self output write: #[ 1 2 3 4 7 8 9 0 ].
	[self output -- 4] on: Error do: [self deny: self output isPositionable].
	self assert: (self output insert: #[ 5 6 ]) = 2.
	self input isPositionable
		ifTrue: [self assert: (self input read: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ]]
		ifFalse:        [self assert: (self input read: 10) = #[ 1 2 3 4 7 8 9 0 5 6 ]]
!

testPut

	self output put: 1.
	self assert: self input get = 1
!

testReadIntoCollection

	| data out |
	data := #[1 2 3 4 5 6 7].
	self output write: data; close.
	out := ByteArray new: data size.
	self assert: (self input read: 4 into: out) = 4.
	self assert: (self input read: 3 into: out at: 5)  = 3.
	self assert: out = data
!

testReadWriteLargeAmount
	| data |
	1 to: 10 do: [:each | self output put: 1. self assert: self input get = 1].
	#( 64 1024 2048 4096 8192 ) do: [:dataSize |
		data := ByteArray new: dataSize.
		1 to: data size do: [:i | data at: i put: (i - 1) \\ 256].
		self    timeout:        1000 milliseconds
			server: [1 to: 10 do: [:each | self output write: data]. true]
			client:         [(1 to: 10) inject: true into: [:pass :each | pass and: [(self input read: data size) = data]]]]
!

testWriteCollection

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: data) = data size.
	self assert: (self input read: data size) = data
!

testWriteFromCollectionAt

	| data |
	data := #[1 2 3 4 5 6 7].
	self assert: (self output write: 4 from: data at: 1) = 4.
	self assert: (self input read: 4) = (data first: 4).
	self assert: (self output write: 3 from: data at: 5) = 3.
	self assert: (self input read: 3) = (data last: 3)
!

testWriteFromStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: 3 from: data) = 3.
	self assert: (self input read: 3) = #[ 1 2 3 ].
	self assert: (self output write: 1 from: data) = 1.
	self assert: self input get = 4.
	self assert: (
		[       self output write: 2 from: data. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ])
! !

!ReadingWritingTest methodsFor:'tests - core - positioning'!

testReadPositioningSeek

	| record in |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	self output write: record; close.
	in := self input positioning.
	self assert: (in ++ 7) = 7.
	self assert: in position = 7.
	self assert: (in -- 3) = 3.
	self assert: in position = 4.
!

testWriteExplore

	| record mark out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	mark := out position.
	out
		write: 0;
		write: record;
		explore: [out += mark; write: record size];
		close.
	self assert: (self input read: record size + 1) = ((ByteArray with: record size), record)
!

testWritePositioningSeek

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out     write: record.
	self assert: (out -- 7) = 7.
	self assert: out position = 3.
	self assert: (out ++ 3) = 3.
	self assert: out position = 6.
	self assert: (out ++ 4) = 4.
	out close.
	self assert: (self input read: record size) = record
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
!

testReadDecodingCRLF

	| result |
	self output write: #[104 101 108 108 111 13 10 119 111 114 108 100 10 13 13 10 10 ]; close.
	result := (self input encoding: #ascii) read: 15.
	self assert: result = 'hello\world\\\\' withCRs
!

testReadDecodingTransparent

	| result bytes |
	bytes := #[104 101 108 108 111 13 10 119 111 114 108 100 13 10 13 10 13 10 ].
	self output write: bytes; close.
	result := (self input encoding: #ascii) setLineEndTransparent read: bytes size.
	self assert: result = (String withAll: (bytes asArray collect: #asCharacter))
!

testReadDecodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	self output write: bytes; close.
	result := (self input encoding: #utf16) read: 12.
	self assert: result = 'Hello World!!'
!

testReadDecodingUTF8

	| result bytes text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	bytes := #[80 197 153 195 173 108 105 197 161 32 197 190 108 117 197 165 111 117 196 141 107 195 189 32 107 197 175 197 136 32 195 186 112 196 155 108 32 196 143 195 161 98 101 108 115 107 195 169 32 195 179 100 121].
	self output write: bytes; close.
	result := (self input encoding: #utf8) read: text size.
	self assert: result = text
!

testWriteEncodingBase64
	((self output encoding: #ascii) encodingBase64 encoding: #ascii)
		write: 'Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure.';
		close.
	self assert: ((self input encoding: #ascii) read: 360) = 'TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4='
!

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
!

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
!

testWriteEncodingUTF16

	| result bytes |
	bytes := #[0 72 0 101 0 108 0 108 0 111 0 32 0 87 0 111 0 114 0 108 0 100 0 33].
	(self output encoding: #utf16) write: 'Hello World!!'; close.
	result := self input read: 24.
	self assert: result = bytes
!

testWriteEncodingUTF8

	| result bytes text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	bytes := #[80 197 153 195 173 108 105 197 161 32 197 190 108 117 197 165 111 117 196 141 107 195 189 32 107 197 175 197 136 32 195 186 112 196 155 108 32 196 143 195 161 98 101 108 115 107 195 169 32 195 179 100 121].
	(self output encoding: #utf8) write: text; close.
	result := self input read: bytes size.
	self assert: result = bytes
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
!

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
!

testReadUnsignedShortEndianness

	self output write: #[ 16rFF 16r00 16rFF 00]; close.
	self assert: (self input interpreting: #unsignedShort_le) get = 16rFF.
	self assert: (self input interpreting: #unsignedShort_be) get = 16rFF00.
!

testWriteUnsignedShortEndianness

	(self output interpreting: #unsignedShort_le) put: 16rFF.
	(self output interpreting: #unsignedShort_be) put: 16rFF00.
	self output close.
	self assert: (self input read: 4) = #[ 16rFF 16r00 16rFF 00]
! !

!ReadingWritingTest methodsFor:'tests - transforming'!

testCharacters
        (self output encoding: #ascii)
                setLineEndTransparent;
                backspace; bell; cr; delete; ff; lf; q; qq; space; tab; vtab; escape;
                close.
        self assert: (self input read: 12) = #[8 7 13 127 12 10 39 34 32 9 11 27]
!

testDoing
	| outing inning |
	outing := ByteArray new writing.
	(self output doing: [:each | outing put: each]) write: #[ 1 2 3 4 5 ].
	self assert: outing contents = #[ 1 2 3 4 5 ].

	inning := ByteArray new writing.
	self assert: ((self input doing: [:each | inning put: each]) read: 5) = #[ 1 2 3 4 5 ].
	self assert: inning contents = #[ 1 2 3 4 5 ]
!

testReadCollecting
	| data |
	data := #[ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 ].
	self output write: data.
	self assert: ((self input collecting: [:e | e * e]) read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
!

testReadCollectingContentsSpeciesChanged
	| data result |
	data := ByteArray withAll: ((1 to: 16) collect: [:index | 65]).
	self output write: data.
	result :=
		(self input collecting: [:e | Character codePoint: e])
			contentsSpecies: String;
			read: data size.
	self assert: result = (String withAll: (data asArray collect: [:e | Character codePoint: e]))
!

testReadDuplicating

	| copy contents |
	contents := Array withAll: (0 to: 15).
	copy := Array new writing.
	self assert: (contents reading duplicating: copy) rest = contents.
	self assert: copy conclusion = contents
!

testReadInjecting
	self output write: #[ 1 2 3 4 ].
	self assert: ((self input injecting: 0 into: [:all :each | all + each]) read: 4) = #[ 1 3 6 10 ]
!

testReadRejecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input rejecting: #even) read: 5) = #[ 1 3 5 7 9 ]
!

testReadSelecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input selecting: #even) read: 4) = #[ 2 4 6 8 ]
!

testReadTransforming1into2
	| result |
	self output write: #[ 1 2 3 ].
	result :=
		(self input transforming: [:in :out | | x | x := in get. out put: x; put: x])
			read: 6.
	self assert: result = #[ 1 1 2 2 3 3 ]
!

testReadTransforming2into1
	| result |
	self output write: #[ 1 2 3 4 ].
	result :=
		(self input transforming: [:in :out | in get. out put: in get])
			read: 2.
	self assert: result = #[ 2 4 ]
!

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
!

testWriteCollecting
	| data |
	data := 1 to: 15.
	(self output collecting: [:e | e * e]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e * e]))
!

testWriteCollectingIncompatibleContentSpecies
	| data |
	data := (1 to: 15) collect: [ :x | x @ 0 ].
	(self output collecting: [:e | e x ]) write: data.
	self assert: (self input read: data size) = (ByteArray withAll: (data collect: [:e | e x]))
!

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
!

testWriteDuplicating

	| original copy contents |
	contents := Array withAll: (0 to: 15).
	original := Array new writing.
	copy := Array new writing.
	(original duplicating: copy) write: contents.
	self assert: original conclusion = contents.
	self assert: copy conclusion = contents
!

testWriteInjecting
	(self output injecting: 0 into: [:all :each | all + each])
		write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 4) = #[ 1 3 6 10 ]
!

testWriteRejecting
	(self output rejecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 5) = #[ 1 3 5 7 9 ]
!

testWriteSelecting
	(self output selecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
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
	self assert: self input get = 16rAB.
	hex2Byte write: 'cdef'.
	hex2Byte close.
	result := self input read: 2.
	self assert: result = #[16rcd 16ref].
!

testWriteTransforming1into2
	| result |
	(self output transforming: [:in :out | | x | x := in get. out put: x; put: x])
		write: #[ 1 2 3 ];
		close.
	result := (self input read: 6).
	self assert: result = #[ 1 1 2 2 3 3 ]
!

testWriteTransforming2into1
	| result |
	(self output transforming: [:in :out | in get. out put: in get])
		write: #[ 1 2 3 4 ];
		close.
	result := self input read: 2.
	self assert: result = #[ 2 4 ]
! !

!ReadingWritingTest methodsFor:'utilities'!

timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	self assert: serverBlock value.
	self assert: clientBlock value.
! !

!ReadingWritingTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ReadingWritingTest.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#PositionReadStreamTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!


!PositionReadStreamTest methodsFor:'tests'!

testIncompleteCounts

	| x oneToTen |
	oneToTen := [ (x := x + 1) > 10 ifTrue: [ Incomplete zero raise ]. x ].
	x := 0.
	self assert: ([ oneToTen reading positioning read: 5; -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	x := 0.
	self assert: ([ oneToTen reading positioning read: 5; ++ 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	x := 0.
	self assert: ([ oneToTen reading positioning -= 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	x := 0.
	self assert: ([ oneToTen reading positioning += 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	self assert: ([ (1 to: 10) reading positioning read: 5; -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (1 to: 10) reading positioning read: 5; ++ 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (1 to: 10) reading positioning -= 12 ] on: Incomplete do: [:ex | ex count]) = 10.
	self assert: ([ (1 to: 10) reading positioning += 12 ] on: Incomplete do: [:ex | ex count]) = 10.
! !

!PositionReadStreamTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionReadStreamTest.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

LibraryDefinition subclass:#stx_goodies_xtreams_core_tests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!


!stx_goodies_xtreams_core_tests class methodsFor:'description'!

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
        #'stx:goodies/sunit'    "TestAsserter - superclass of Xtreams::ReadingWritingTest "
        #'stx:goodies/xtreams/core'    "Xtreams::PositionWriteStream - referenced by Xtreams::FiniteReadingWritingTests>>testWritePositioningWithRingBuffer "
        #'stx:goodies/xtreams/substreams'
        #'stx:libbasic'    "Object - superclass of Xtreams::ReadingWritingTest "
    )
! !

!stx_goodies_xtreams_core_tests class methodsFor:'description - contents'!

classNamesAndAttributes
    "lists the classes which are to be included in the project.
     Each entry in the list may be: a single class-name (symbol),
     or an array-literal consisting of class name and attributes.
     Attributes are: #autoload or #<os> where os is one of win32, unix,..."

    ^ #(
        "<className> or (<className> attributes...) in load order"
        (#'Xtreams::BufferTest' autoload)
        (#'Xtreams::ElasticBufferTest' autoload)
        (#'Xtreams::PositionReadStreamTest' autoload)
        (#'Xtreams::PositionWriteStreamTest' autoload)
        (#'Xtreams::ReadingWritingTest' autoload)
        (#'Xtreams::RingBufferTest' autoload)
        #'Xtreams::stx_goodies_xtreams_core_tests'
        (#'Xtreams::FiniteReadingWritingTests' autoload)
        (#'Xtreams::InfiniteReadingWritingTests' autoload)
    )
!

extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
    )
! !

!stx_goodies_xtreams_core_tests class methodsFor:'description - project information'!

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

!stx_goodies_xtreams_core_tests class methodsFor:'description - svn'!

svnRepositoryUrlString
    "Return a SVN repository URL of myself.
     (Generated since 2011-04-08)
    "        

    ^ '$URL: https://swing.fit.cvut.cz/svn/stx/goodies/xtreams/trunk/core/tests/stx_goodies_xtreams_core_tests.st $'
!

svnRevisionNr
    "Return a SVN revision number of myself.
     This number is updated after a commit"

    ^ "$SVN-Revision:"'22'"$"
! !

!stx_goodies_xtreams_core_tests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_core_tests.st 13 2011-11-21 06:01:33Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#RingBufferTest
	instanceVariableNames:'output buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!


!RingBufferTest methodsFor:'initialize-release'!

setUp

	buffer := RingBuffer on: 'xxxx' copy
! !

!RingBufferTest methodsFor:'tests'!

testClear

	| cacheSize |
	buffer write: 4 from: '1234' at: 1.
	cacheSize := buffer cacheSize.
	buffer clear.
	self assert: buffer cacheSize = cacheSize.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer writeSize = cacheSize
!

testInsertInTheMiddle

	| chunk |
	chunk := 'hello'.
	buffer := RingBuffer on: (String new: chunk size * 5).
	buffer write: chunk; write: chunk.
	buffer writePosition: chunk size.
	buffer insert: chunk.
	self assert: buffer writePosition = (chunk size * 2).
	self assert: buffer activeSize = (chunk size * 3)
!

testRead

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	self assert: output = '1www'.
	self assert: buffer readPosition = 1.
	self assert: buffer readSize = 3.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 1.
	buffer read: 3 into: output at: 2.
	self assert: output = '1234'.
	self assert: buffer readPosition = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4
!

testReadOverflow

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	self should: [buffer read: 6 into: output at: 1] raise: Incomplete.
	self assert: output = '1234ww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
!

testReadWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 3 from: 'ABC' at: 1.
	output := 'wwww' copy.
	buffer read: 4 into: output at: 1.
	self assert: output = '4ABC'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
!

testReadWriteFirstHalf

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	self assert: output = '12ww'.
	self assert: buffer cache = '1234'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2.
	buffer write: 2 from: 'AB' at: 1.
	self assert: buffer cache = 'AB34'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	output := 'wwww' copy.
	buffer read: 2 into: output at: 1.
	self assert: output = '34ww'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2
!

testReadWriteSecondHalf
	" <--- SomeData ... ReadAt ... WriteAt/DataEnd DataStart ... SomeData ---> "

	output := 'wwww' copy.
	buffer write: 3 from: '123' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 3 from: 'ABC' at: 1.
	buffer read: 2 into: output at: 1.
	output := 'wwww' copy.
	buffer read: 1 into: output at: 1.
	self assert: output = 'Cwww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
!

testReadWriteWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	self assert: output = '123w'.
	self assert: buffer cache = '1234'.
	self assert: buffer readPosition = 3.
	self assert: buffer readSize = 1.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 3.
	buffer write: 1 from: 'A' at: 1.
	self assert: buffer cache = 'A234'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2.
	buffer write: 2 from: 'BC' at: 1.
	self assert: buffer cache = 'ABC4'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	output := 'wwww' copy.
	buffer read: 4 into: output at: 1.
	self assert: output = '4ABC'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
!

testTrim

	output := 'wwww' copy.
	buffer write: 3 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	buffer writeSkip: -1.
	buffer trim.
	self assert: buffer cacheSize = 2.
	self assert: buffer cache = '23'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 2.
	self assert: buffer writeSize = 0
!

testTrimInsideOut

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 2 from: 'AB' at: 1.
	buffer writeSkip: -1.
	buffer trim.
	self assert: buffer cacheSize = 2.
	self assert: buffer cache = '4B'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 2.
	self assert: buffer writeSize = 0
!

testWrite

	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.
	buffer write: 1 from: '1234' at: 1.
	self assert: buffer cache = '1xxx'.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer write: 3 from: '1234' at: 2.
	self assert: buffer cache = '1234'.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
!

testWriteObject
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.

	buffer put: $1.
	self assert: buffer cache first = $1.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer put: $2; put: $3; put: $4.
	self assert: buffer cache = '1234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0.
	buffer put: $5.
	self assert: buffer cache = '5234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
!

testWriteOverflow0

	buffer write: 1 from: '1234' at: 1.
	buffer write: 4 from: 'ABCD' at: 1.
	self assert: buffer cache = 'ABCD'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
!

testWriteOverflow1

	buffer write: 1 from: '1234' at: 1.
	buffer write: 5 from: 'ABCDE' at: 1.
	self assert: buffer cache = 'BCDE'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
!

testWriteWrap

	buffer write: 3 from: '1234' at: 1.
	buffer write: 2 from: 'AB' at: 1.
	self assert: buffer cache = 'B23A'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
! !

!RingBufferTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__RingBufferTest.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

ReadingWritingTest subclass:#FiniteReadingWritingTests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!

FiniteReadingWritingTests comment:'These are tests that require a stream that can be effectively closed, i.e. not pointer or shared queue stream.

'
!


!FiniteReadingWritingTests methodsFor:'tests - core'!

testGet
	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input get = 1.
	self assert: self input get = 2.
	self assert: self input get = 3.
	self assert: self input get = 4.
	self should: [self input get] raise: Incomplete
!

testGetPastEnd
	self output put: 120.
	self output close.
	self assert: self input get = 120.
	self should: [self input get] raise: Incomplete
!

testRead

	self output write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 3) = #[1 2 3].
	self assert: ([self input read: 2. false] on: Incomplete do: [:exception |
		exception collection first = 4.
		exception collection size = 2.
		exception count = 1.
		true])
!

testReadIntoAt
	| result |
	self output write: #[ 1 2 3 4 ]; close.
	result := ByteArray new: 8 withAll: 255.
	self input read: 3 into: result at: 3.
	self assert: result = #[255 255 1 2 3 255 255 255].
	self input read: 1 into: result at: 6.
	self assert: result = #[255 255 1 2 3 4 255 255].
	self should: [self input get] raise: Incomplete.
	self should: [self input read: 3 into: result at: 5] raise: Incomplete.
	self assert: result = #[255 255 1 2 3 4 255 255].
!

testReadIntoAtPastEnd
	| result |

	self output write: #[ 1 2 3 4 ]; close.
	self input read: 1.
	result := ByteArray new: 4 withAll: 255.
	self assert: ([self input read: 4 into: result at: 1. false] on: Incomplete do: [ :eos | eos count = 3 ]).
	self assert: result = #[2 3 4 255]
!

testRest

	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input rest = #[1 2 3 4].
	self assert: self input rest = #[]
!

testWriteStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: data) = 4.
	self shouldnt: [ self output write: data ] raise: Incomplete.
	self output close.
	self assert: (self input read: 4) = #[ 1 2 3 4 ].
	self should: [self input get] raise: Incomplete
!

testWriteTruncating

	self output positioning
		write: #[1 2 3 4 5 6];
		-- 3;
		write: #[1 2];
		close.
	self assert: self input rest = #[1 2 3 1 2].
! !

!FiniteReadingWritingTests methodsFor:'tests - core - positioning'!

testReadPositioningSeek

	| record in |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	self output write: record; close.
	in := self input positioning.
	self assert: (in ++ 7) = 7.
	self assert: in position = 7.
	self assert: (in -- 3) = 3.
	self assert: in position = 4.
	self assert: ([ in ++ record size ] on: Incomplete do: [:ex | ex count]) = (record size - 4).
!

testReadPositioningSeekFrom

	| record in |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	self output write: record; close.
	in := self input positioning.
	self assert: (in += 3) = 3.
	self assert: in position = 3.
	self assert: (in -= 4) = 4.
	self assert: in position = 6.
	self assert: ([ in -= (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: in position = 0.
	self assert: ([ in += (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: in position = record size.
!

testWritePositioningSeek

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out     write: record.
	self assert: (out -- 7) = 7.
	self assert: out position = 3.
	self assert: (out ++ 3) = 3.
	self assert: out position = 6.
	self assert: ([ out ++ record size ] on: Incomplete do: [:ex | ex count]) = (record size - 6).
	out close.
	self assert: (self input read: record size) = record
!

testWritePositioningSeekFrom

	| record out |
	record := #[ 1 2 3 4 5 6 7 8 9 0 ].
	out := self output positioning.
	out     write: record.
	self assert: (out += 3) = 3.
	self assert: out position = 3.
	self assert: (out -= 4) = 4.
	self assert: out position = 6.
	self assert: ([ out -= (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: out position = 0.
	self assert: ([ out += (record size + 6) ] on: Incomplete do: [:ex | ex count]) = record size.
	self assert: out position = record size.
	out close.
	self assert: (self input read: record size) = record
! !

!FiniteReadingWritingTests methodsFor:'tests - enumeration'!

testCollect

	| data result |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := self input collect: [ :e | e * e ].
	self assert: result size = data size.
	data with: result do: [ :in :out | self assert: in * in = out ]
!

testDetect

	| data result |
	data := ByteArray withAll: (1 to: 15).
	self output write: data; close.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 4.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 8.
	result := self input detect: [ :e | e \\ 4 = 0 ].
	self assert: result = 12.
	result := self input detect: [ :e | e \\ 4 = 0 ] ifNone: [ nil ].
	self assert: result = nil
!

testDo

	| data result i |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := ByteArray new: data size.
	i := 1.
	self input do: [ :e | result at: i put: e * e. i := i + 1 ].
	data with: result do: [ :in :out | self assert: in * in = out ]
!

testSelect

	| data result |
	data := ByteArray withAll: (0 to: 15).
	self output write: data; close.
	result := self input select: [ :e | e odd ].
	self assert: result = (data select: [ :e | e odd ]).
! !

!FiniteReadingWritingTests methodsFor:'tests - interpreting'!

testInterpretingDoubles
	| doubles result |
	doubles := (1 to: 10) reading collect: [ :i | i reciprocal asDouble ].
	(self output interpreting: #double) write: doubles; close.
	result := (self input interpreting: #double) rest.
	self assert: result = doubles
! !

!FiniteReadingWritingTests methodsFor:'tests - seeking'!

testExploreInsideExplore
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [(in explore: [in rest = #[1 2 3 4]]) & (in rest = #[1 2 3 4])]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testExploreRead
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [in rest = #[1 2 3 4]]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testExploreSeekBackward
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [in read: 3; -- 1. in rest = #[3 4]]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testExploreSeekBackwardPastBeginning
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self should: [ in explore: [in read: 2; -- 4 ] ] raise: Incomplete.
	self should: [ in explore: [in read: 2; -= 6 ] ] raise: Incomplete.
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testExploreSeekForward
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [in ++ 2. in rest = #[3 4]]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testExploreSeekForwardPastEnd
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self should: [ in explore: [in ++ 8] ] raise: Incomplete.
	self should: [ in explore: [in += 8] ] raise: Incomplete.
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
!

testSeekBackward

	self output write: #[ 1 2 3 4 ]; close.
	self input read: 2.
	[self input -- 2] on: Error do: [:error |
		self deny: self input isPositionable].
	self input isPositionable
		ifTrue: [self assert: self input rest = #[1 2 3 4]]
		ifFalse:        [self assert: self input rest = #[3 4]].
!

testSeekBackwardPastBeginning

	self output write: #[ 1 2 3 4 ]; close.
	[[self input -- 1]
		on: Incomplete do: [:incomplete | ^self assert: incomplete count = 0]]
		on: Error do: [:error | ^self deny: self input isPositionable].

	"If neither exception was raised, that is a problem."
	self deny: true
!

testSeekForward

	self output write: #[ 1 2 3 4 ]; close.
	self assert: (self input ++ 2) = 2.
	self assert: self input rest = #[3 4].
!

testSeekForwardPastEnd

	self output write: #[ 1 2 3 4 ]; close.
	self input ++ 2.
	self assert: (
		[       self input ++ 4. false
		] on: Incomplete do: [ :eos |
			eos count = 2 ]).
	self should: [ self input get ] raise: Incomplete.
	self assert: (
		[       self input ++ 4. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ]).
!

testWritePositioningInsert

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(PositionWriteStream on: self output)
		write: message; write: message;
		+= message size;
		insert: message;
		-= 0;
		close.
	result := self input rest.
	self assert: result = (message, message, message)
!

testWritePositioningWithRingBuffer

	| message result |
	message := ByteArray withAll: (1 to: 20).
	(PositionWriteStream on: self output)
		buffer: (RingBuffer on: (ByteArray new: 5));
		write: message;
		close.
	result := self input rest.
	self assert: result = message
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
!

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
!

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
!

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
!

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
!

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
!

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
!

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
!

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
!

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
!

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
!

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
!

testWriteClosing
	| closing suboutput |
	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 1 1 ]; close.

	suboutput := closing get.
	suboutput write: #[ 2 2 2 ]; close.
	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]
!

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
!

testWriteEndingBlock
	| ender |
	ender := (self output ending: [:e | e = 4]) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
!

testWriteEndingBlockTail
	| ender |
	ender := (self output ending: [:e | e = 4] inclusive: true) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
!

testWriteEndingCollection
	| ender |
	ender := (self output ending: #[ 1 2 3 ]) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 7) = #[ 0 1 1 2 4 5 6 ].
	self should: [self input get] raise: Incomplete
!

testWriteEndingCollectionTail
	| ender |
	ender := (self output ending: #[ 1 2 3 ] inclusive: true) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 10) = #[ 0 1 1 2 1 2 3 4 5 6 ].
	self should: [self input get] raise: Incomplete
!

testWriteEndingObject
	| ender |
	ender := (self output ending: 4) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
!

testWriteEndingObjectTail
	| ender |
	ender := (self output ending: 4 inclusive: true) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
!

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
!

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
!

testReadStitchingChunks
"Chunks are prefixed with size in the first byte. Below we have 3 chunks of size 1, 3 and 7, and terminating 0 chunk."

	| chunks contents stitched |
	chunks := (ByteArray withAll: (1 to: 14)), #[0].
	self output write: chunks; close.
	stitched := [ self input limiting: self input get ] reading stitching.
	contents := stitched rest.
	self assert: contents = #[2 4 5 6 8 9 10 11 12 13 14]
!

testWriteStitchLimiting
	| limiting |
	limiting := [self output limiting: 3] reading stitching.

	limiting write: #[ 1 1 1 2 2 2 3 3 3 ].
	limiting close.

	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]
!

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
!

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

!FiniteReadingWritingTests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__FiniteReadingWritingTests.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#ElasticBufferTest
	instanceVariableNames:'output buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!


!ElasticBufferTest methodsFor:'initialize-release'!

setUp

	buffer := ElasticBuffer on: String new
! !

!ElasticBufferTest methodsFor:'tests'!

testClear

	buffer write: 4 from: '1234' at: 1.
	buffer clear.
	self assert: buffer cacheSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer writeSize = 0
!

testRead

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	self assert: output = '1www'.
	self assert: buffer readPosition = 1.
	self assert: buffer readSize = 3.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 5.
	buffer read: 3 into: output at: 2.
	self assert: output = '1234'.
	self assert: buffer readPosition = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 8
!

testReadOverflow

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	self should: [buffer read: 6 into: output at: 1] raise: Incomplete.
	self assert: output = '1234ww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 8
!

testReadWrap

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 6 from: 'ABCDEF' at: 1.
	output := 'wwwwww' copy.
	buffer read: 6 into: output at: 1.
	self assert: output = '4ABCDE'.
	self assert: buffer readPosition = 7.
	self assert: buffer readSize = 1.
	self assert: buffer writePosition = 8.
	self assert: buffer writeSize = 7
!

testTrim

	output := 'wwww' copy.
	buffer write: 3 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	buffer writeSkip: -1.
	buffer trim.
	self assert: buffer cacheSize = 2.
	self assert: buffer cache = '23'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 2.
	self assert: buffer writeSize = 0
!

testTrimInsideOut

	buffer := ElasticBuffer on: 'xxxx' copy.
	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 2 from: 'AB' at: 1.
	buffer writeSkip: -1.
	buffer trim.
	self assert: buffer cacheSize = 2.
	self assert: buffer cache = '4B'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 2.
	self assert: buffer writeSize = 0
!

testWrite

	buffer := ElasticBuffer on: 'xxxx' copy.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.
	buffer write: 1 from: '1234' at: 1.
	self assert: buffer cache = '1xxx'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer write: 3 from: '1234' at: 2.
	self assert: buffer cache = '1234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
!

testWriteGrow

	self assert: buffer cacheSize = 0.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 0.
	buffer write: 4 from: '1234' at: 1.
	self assert: (buffer cache first: 4) = '1234'.
	self assert: buffer cacheSize = 8.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 4
!

testWriteObject

	self assert: buffer cacheSize = 0.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 0.
	buffer put: $1.
	self assert: buffer cache first = $1.
	self assert: buffer cacheSize = 2.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 1.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 1.
	buffer put: $2; put: $3; put: $4.
	self assert: (buffer cache first: 4) = '1234'.
	self assert: buffer cacheSize = 6.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 2.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 2.
	buffer put: $5.
	self assert: (buffer cache first: 5) = '12345'.
	self assert: buffer cacheSize >= 5.
	self assert: buffer activeSize = 5.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 5.
	self assert: buffer readSize = 5.
!

testWriteWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	buffer write: 6 from: 'ABCDEF' at: 1.
	self assert: buffer cache = 'EF34ABCD'.
	self assert: buffer cacheSize = 8.
	self assert: buffer activeSize = 8.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 8.
	self assert: buffer readSize = 8.
	self assert: buffer writeSize = 0
!

testWriteWrapOverflow

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	buffer write: 5 from: 'ABCDE' at: 1.
	buffer write: 3 from: 'XYZ' at: 1.
	self assert: (buffer cache first: 4) = 'EXYZ'.
	self assert: (buffer cache last: 4) = 'ABCD'.
	self assert: buffer cacheSize = 20.
	self assert: buffer activeSize = 11.
	self assert: buffer inactiveSize = 9.
	self assert: buffer readPosition = 1.
	self assert: buffer writePosition = 11.
	self assert: buffer readSize = 10.
	self assert: buffer writeSize = 10
! !

!ElasticBufferTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__ElasticBufferTest.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#BufferTest
	instanceVariableNames:'output buffer'
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!


!BufferTest methodsFor:'initialize-release'!

setUp

	buffer := Buffer on: String new
! !

!BufferTest methodsFor:'tests'!

testClear

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer clear.
	buffer write: 4 from: 'ABCD' at: 1.
	buffer read: 4 into: output at: 1.
	self assert: output = 'ABCD'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 8
!

testInsertInTheMiddle

	| chunk |
	chunk := 'hello'.
	buffer write: chunk; write: chunk.
	buffer writePosition: chunk size.
	buffer insert: chunk.
	self assert: buffer writePosition = (chunk size * 2).
	self assert: buffer activeSize = (chunk size * 3)
!

testRead

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	self assert: output = '1www'.
	self assert: buffer readPosition = 1.
	self assert: buffer readSize = 3.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 5.
	buffer read: 3 into: output at: 2.
	self assert: output = '1234'.
	self assert: buffer readPosition = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 8
!

testReadOverflow

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	self should: [buffer read: 6 into: output at: 1] raise: Incomplete.
	self assert: output = '1234ww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 8
!

testTrim

	output := 'wwww' copy.
	buffer write: 8 from: '12345678' at: 1.
	buffer read: 2 into: output at: 1.
	buffer writeSkip: -2.
	buffer trim.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	buffer read: 4 into: output at: 1.
	self assert: output = '3456'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
!

testWrite

	buffer := Buffer on: 'xxxx' copy.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.
	buffer write: 1 from: '1234' at: 1.
	self assert: buffer cache = '1xxx'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer write: 3 from: '1234' at: 2.
	self assert: buffer cache = '1234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
!

testWriteGrow

	self assert: buffer cacheSize = 0.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 0.
	buffer write: 4 from: '1234' at: 1.
	self assert: (buffer cache first: 4) = '1234'.
	self assert: buffer cacheSize = 8.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 4
!

testWriteObject

	buffer := Buffer on: 'xxxx' copy.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.
	buffer put: $1.
	self assert: buffer cache = '1xxx'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer put: $2; put: $3; put: $4.
	self assert: buffer cache = '1234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0.
	buffer put: $5.
	self assert: (buffer cache first: 5) = '12345'.
	self assert: buffer cacheSize >= 5.
	self assert: buffer activeSize = 5.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 5.
	self assert: buffer readSize = 5.
! !

!BufferTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__BufferTest.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

ReadingWritingTest subclass:#InfiniteReadingWritingTests
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!

InfiniteReadingWritingTests comment:'These are tests specifically for those streams that cannot be effectively closed, i.e. pointer and shared queue streams.

'
!


!InfiniteReadingWritingTests methodsFor:'tests - core'!

testGet
	self output write: #[ 1 2 3 4 ].
	self assert: self input get = 1.
	self assert: self input get = 2.
	self assert: self input get = 3.
	self assert: self input get = 4
!

testRead
	self output write: #[ 1 2 3 4 ].
	self assert: (self input read: 3) = #[1 2 3].
	self assert: self input get = 4
! !

!InfiniteReadingWritingTests class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__InfiniteReadingWritingTests.st 4 2011-08-22 15:45:26Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 14-01-2012 at 09:32:10 PM'                  !

"{ Package: 'stx:goodies/xtreams/core/tests' }"

"{ NameSpace: Xtreams }"

TestCase subclass:#PositionWriteStreamTest
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Xtreams-Core-Tests'
!


!PositionWriteStreamTest methodsFor:'tests'!

testIncompleteCounts

	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); ++ 8 ] on: Incomplete do: [:ex | ex count]) = 0.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); -= 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ ([ :x | ] writing limiting: 10) positioning write: (1 to: 5); += 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); -- 8 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); ++ 8 ] on: Incomplete do: [:ex | ex count]) = 0.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); -= 12 ] on: Incomplete do: [:ex | ex count]) = 5.
	self assert: ([ (Array new: 10) writing positioning write: (1 to: 5); += 12 ] on: Incomplete do: [:ex | ex count]) = 5.
! !

!PositionWriteStreamTest class methodsFor:'documentation'!

version_SVN
    ^ '$Id: Xtreams__PositionWriteStreamTest.st 4 2011-08-22 15:45:26Z mk $'
! !
