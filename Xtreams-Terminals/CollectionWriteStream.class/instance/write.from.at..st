"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index |
		destination add: (aSequenceableCollection at: index)].
	^anInteger
