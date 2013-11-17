"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	super read: anInteger into: aSequenceableCollection at: startIndex.
	position := position + anInteger.
	^anInteger
