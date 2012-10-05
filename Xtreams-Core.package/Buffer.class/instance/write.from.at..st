accessing - writing
write: anInteger from: aSequenceableCollection at: startIndex

	writePosition + anInteger <= cache size ifFalse: [self growBy: anInteger].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger