"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	[destination insert: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger