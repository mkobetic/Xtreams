accessing
write: anInteger from: aSequenceableCollection at: startIndex

	[	destination write: anInteger from: aSequenceableCollection at: startIndex
	] on: Incomplete do: [ :incomplete |
		duplicate write: incomplete count from: aSequenceableCollection at: startIndex.
		incomplete pass ].
	duplicate write: anInteger from: aSequenceableCollection at: startIndex.
	^anInteger