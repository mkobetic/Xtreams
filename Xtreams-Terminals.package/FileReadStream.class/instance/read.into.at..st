"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	super read: anInteger into: aSequenceableCollection at: startIndex.
	position := position + anInteger.
	^anInteger