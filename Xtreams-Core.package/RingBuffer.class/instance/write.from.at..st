"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
write: anInteger from: aSequenceableCollection at: startIndex

	anInteger < cache size ifTrue:  [self privateWrite: anInteger from: aSequenceableCollection at: startIndex. ^anInteger].

	" Do the quick store, since we're a ring "
	dataPosition := readPosition := 0.
	dataLength := writePosition := cache size.
	cache replaceFrom: 1 to: cache size with: aSequenceableCollection startingAt: startIndex + anInteger - cache size.
	^anInteger