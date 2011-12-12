'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__WriteSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__StitchReadStream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__PositionWriteSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

"{ Package: 'stx:goodies/xtreams/substreams' }"

LibraryDefinition subclass:#stx_goodies_xtreams_substreams
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'* Projects & Packages *'
!

!stx_goodies_xtreams_substreams class methodsFor:'documentation'!

extensionsVersion_SVN
    ^ '$Id: extensions.st 14 2011-11-21 06:01:55Z mkobetic $'
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
        #'stx:goodies/xtreams/core'    "Xtreams::WriteStream - superclass of Xtreams::MatchWriteSubstream "
        #'stx:goodies/xtreams/terminals'
        #'stx:libbasic'    "Object - superclass of Xtreams::LimitReadSubstream "
        #'stx:libbasic2'
        #'stx:libcompat'
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

    ^ "$SVN-Revision:"'23'"$"
! !

!stx_goodies_xtreams_substreams class methodsFor:'documentation'!

version_SVN
    ^ '$Id: stx_goodies_xtreams_substreams.st 14 2011-11-21 06:01:55Z mkobetic $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__MatchWriteSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__ReadSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__StitchWriteStream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__PositionReadSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__TestReadSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__LimitWriteSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__TestWriteSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__MatchReadSubstream.st 5 2011-08-22 15:46:38Z mk $'
! !
'From Smalltalk/X, Version:6.2.1 on 11-12-2011 at 07:34:49 PM'                  !

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
    ^ '$Id: Xtreams__LimitReadSubstream.st 5 2011-08-22 15:46:38Z mk $'
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

!Block methodsFor:'private'!

streamingReadMatching: aStream inclusive: tail
	^TestReadSubstream on: aStream test: self inclusive: tail
! !

!Block methodsFor:'private'!

streamingWriteMatching: aStream inclusive: tail
	^TestWriteSubstream on: aStream test: self inclusive: tail
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

!SequenceableCollection methodsFor:'private'!

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

!SequenceableCollection methodsFor:'private'!

streamingReadMatching: aStream inclusive: tail
	"Return a stream that produces substreams that separate by @pattern and include the pattern in the result if @tail is true.
	 It uses the Knuth-Morris-Pratt algorithm, from Cormen et al.'s Algorithms, page 871. See also Gusfield's Alorithms on Strings, Trees and Sequences, page 23. This algorithm has the advantage in stream matching that it reads every character in the the text to be matched against exactly once, and never backtracks."

	| backtrack |
	backtrack := self streamingMatchPrefixFunction.
	^MatchReadSubstream on: aStream pattern: self backtrack: backtrack inclusive: tail
! !

!SequenceableCollection methodsFor:'private'!

streamingWriteMatching: aStream inclusive: tail
	"Return a stream that produces substreams that separate by @pattern and include the pattern in the result if @tail is true.
	 It uses the Knuth-Morris-Pratt algorithm, from Cormen et al.'s Algorithms, page 871. See also Gusfield's Alorithms on Strings, Trees and Sequences, page 23. This algorithm has the advantage in stream matching that it reads every character in the the text to be matched against exactly once, and never backtracks."

	| backtrack |
	backtrack := self streamingMatchPrefixFunction.
	^MatchWriteSubstream on: aStream pattern: self backtrack: backtrack inclusive: tail
! !

!Object methodsFor:'private'!

streamingReadMatching: aStream inclusive: tail
	^[:each | each == self] streamingReadMatching: aStream inclusive: tail
! !

!Object methodsFor:'private'!

streamingWriteMatching: aStream inclusive: tail
	^[:each | each == self] streamingWriteMatching: aStream inclusive: tail
! !

