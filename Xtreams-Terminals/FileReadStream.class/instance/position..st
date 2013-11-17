"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position: aPosition

	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	source seekTo: available from: #begin.
	position := available.
	cacheDataSize := cachePosition := 0.
	available = aPosition ifTrue: [^aPosition].
	(Incomplete count: available) raise