accessing
read: anInteger into: aSequenceableCollection at: startIndex
	[source read: anInteger into: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		sourceAtEnd := true.
		position := position + incomplete count.
		incomplete pass].
	position := position + anInteger.
	^anInteger