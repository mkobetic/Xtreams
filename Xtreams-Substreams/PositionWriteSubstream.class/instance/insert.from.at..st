"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	[destination insert: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger