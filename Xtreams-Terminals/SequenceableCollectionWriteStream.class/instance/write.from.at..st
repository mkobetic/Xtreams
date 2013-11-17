"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| available |
	available := destination size - position.
	available < anInteger ifTrue: [destination := destination copyGrownToAtLeast: destination size + anInteger - available].
	destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
	position := position + anInteger.
	position > length ifTrue: [length := position].
	^anInteger
