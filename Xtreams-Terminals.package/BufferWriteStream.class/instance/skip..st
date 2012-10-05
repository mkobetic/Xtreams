seeking
skip: anInteger
	| count |
	count := destination writeSkip: anInteger.
	count ~= anInteger ifTrue: [(Incomplete count: count) raise]