"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
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