"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	destination := destination copyGrownToAtLeast: destination size + anInteger.
	destination replaceFrom: position + anInteger + 1 to: length + anInteger with: destination startingAt: position + 1.
	destination replaceFrom: position + 1 to: position + anInteger with: aSequenceableCollection startingAt: startIndex.
	position := position + anInteger.
	length := length + anInteger.
	^anInteger
