"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	[destination write: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass].
	^anInteger
