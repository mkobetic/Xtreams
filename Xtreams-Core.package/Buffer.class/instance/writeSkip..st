accessing - writing
writeSkip: anInteger
	| old delta |
	old := writePosition.
	self writePosition: old + anInteger.
	delta := writePosition - old.
	^delta