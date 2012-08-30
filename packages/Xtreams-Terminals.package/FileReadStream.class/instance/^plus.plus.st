seeking
++ anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	source seekTo: position.
	cacheDataSize := cachePosition := 0.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger