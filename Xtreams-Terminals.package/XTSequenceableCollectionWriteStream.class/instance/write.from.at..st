accessing
write: anInteger from: aSequenceableCollection at: startIndex
	
	destination size - position < anInteger ifTrue: [destination := destination grownBy: (destination size max: position + anInteger)].
	destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
	position := position + anInteger.
	position > length ifTrue: [length := position].
	^anInteger