"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - writing
"
write: anInteger from: aSequenceableCollection at: startIndex

	anInteger < cache size ifTrue:  [self privateWrite: anInteger from: aSequenceableCollection at: startIndex. ^anInteger].

	" Do the quick store, since we're a ring "
	dataPosition := readPosition := 0.
	dataLength := writePosition := cache size.
	cache replaceFrom: 1 to: cache size with: aSequenceableCollection startingAt: startIndex + anInteger - cache size.
	^anInteger
