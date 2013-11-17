"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	super read: anInteger into: aSequenceableCollection at: startIndex.
	position := position + anInteger.
	^anInteger
