accessing
read: anInteger into: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | aSequenceableCollection at: index put: source next].
	^anInteger