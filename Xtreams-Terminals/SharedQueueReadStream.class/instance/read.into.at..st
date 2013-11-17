"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	startIndex to: startIndex + anInteger - 1 do: [:index | aSequenceableCollection at: index put: source next].
	^anInteger
