"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - reading
"
readSkip: anInteger
	| old delta |
	old := readPosition.
	self readPosition: old + anInteger.
	delta := readPosition - old.
	^delta
