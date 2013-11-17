"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - writing
"
write: anInteger from: aSequenceableCollection at: startIndex

	writePosition + anInteger <= cache size ifFalse: [self growBy: anInteger].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
