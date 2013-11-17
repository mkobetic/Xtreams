"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
write: anInteger from: aSequenceableCollection at: startIndex

	writePosition + anInteger <= cache size ifFalse: [self growBy: anInteger].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger
