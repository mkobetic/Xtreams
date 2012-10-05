accessing
read: anInteger into: aSequenceableCollection at: startIndex

	super read: anInteger into: aSequenceableCollection at: startIndex.
	position := position + anInteger.
	^anInteger