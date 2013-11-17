"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	startIndex to: anInteger + startIndex - 1 do: [:index |
		marshaler marshal: self object: (aSequenceableCollection at: index).
		self complete].
	^anInteger
