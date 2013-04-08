"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[self writeWait.
		wrote := destination writeFrom: aSequenceableCollection startingAt: startIndex + count for: anInteger - count.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote].
	^anInteger