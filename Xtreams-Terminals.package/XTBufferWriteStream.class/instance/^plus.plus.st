seeking
++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := destination writeSkip: anInteger.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger