seeking
position: aPosition

	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	source seekTo: available.
	position := available.
	cacheDataSize := cachePosition := 0.
	available = aPosition ifTrue: [^aPosition].
	(Incomplete count: available) raise