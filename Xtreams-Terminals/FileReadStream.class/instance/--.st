"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-- anInteger
	| count |
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	source seekTo: position from: #begin.
	cacheDataSize := cachePosition := 0.
	anInteger = count ifTrue: [^anInteger].
	(Incomplete count: count) raise
