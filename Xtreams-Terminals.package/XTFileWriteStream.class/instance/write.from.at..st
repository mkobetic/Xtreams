accessing
write: anInteger from: aSequenceableCollection at: startIndex
	| count wrote |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue:
		[wrote := destination writeFrom: aSequenceableCollection startingAt: startIndex + count count: anInteger.
		wrote isZero ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		count := count + wrote.
		position := position + wrote].
	^anInteger