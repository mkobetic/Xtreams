accessing
read: anInteger into: aSequenceableCollection at: startIndex
	^[source read: anInteger into: aSequenceableCollection at: startIndex] on: Incomplete do: [:incomplete | sourceAtEnd := true. incomplete pass]