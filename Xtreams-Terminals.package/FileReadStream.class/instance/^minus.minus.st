seeking
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	source seekTo: position.
	cacheDataSize := cachePosition := 0.
	anInteger = count ifTrue: [^anInteger].
	(Incomplete count: count) raise