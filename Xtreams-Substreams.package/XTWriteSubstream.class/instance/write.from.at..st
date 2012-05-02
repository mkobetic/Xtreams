accessing
write: anInteger from: aSequenceableCollection at: startIndex
	[destination write: anInteger from: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete |
		destinationAtEnd := true.
		incomplete pass].
	^anInteger