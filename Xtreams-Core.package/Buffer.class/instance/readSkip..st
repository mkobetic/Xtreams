accessing - reading
readSkip: anInteger
	| old delta |
	old := readPosition.
	self readPosition: old + anInteger.
	delta := readPosition - old.
	^delta