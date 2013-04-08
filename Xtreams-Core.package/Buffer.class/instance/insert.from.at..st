"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
insert: anInteger from: aSequenceableCollection at: startIndex

	dataLength + anInteger <= cache size ifFalse: [self growBy: anInteger].

	cache replaceFrom: writePosition + anInteger + 1 to: dataLength + anInteger with: cache startingAt: writePosition + 1.
	cache replaceFrom: writePosition + 1 to: writePosition + anInteger with: aSequenceableCollection startingAt: startIndex.
	writePosition := writePosition + anInteger.
	dataLength := dataLength + anInteger.
	^anInteger