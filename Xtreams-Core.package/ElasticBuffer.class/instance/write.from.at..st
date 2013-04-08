"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
write: anInteger from: aSequenceableCollection at: startIndex

	anInteger <= self writeSize ifFalse: [self growBy: anInteger - self writeSize].
	self privateWrite: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger