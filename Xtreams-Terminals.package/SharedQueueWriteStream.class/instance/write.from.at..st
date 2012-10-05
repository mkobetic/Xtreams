accessing
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | destination nextPut: (aSequenceableCollection at: index)].
	^anInteger