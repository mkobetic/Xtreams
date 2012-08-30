seeking
++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger