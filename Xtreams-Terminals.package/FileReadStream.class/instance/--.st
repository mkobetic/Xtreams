"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
