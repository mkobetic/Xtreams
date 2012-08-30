seeking
++ anInteger
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	position := position + anInteger.
	^anInteger