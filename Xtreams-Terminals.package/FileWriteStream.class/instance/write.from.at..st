"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[wrote := destination writeBytes: anInteger from: aSequenceableCollection startingAt: startIndex + count.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote.
		position := position + wrote].
	^anInteger
