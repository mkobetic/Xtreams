"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	[source read: anInteger into: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		sourceAtEnd := true.
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger
