"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	| count |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	anInteger < 0 ifTrue: [ ^self ++ anInteger negated ].
	count := position min: anInteger.
	position := position - count.
	destination seekTo: position from: #begin.
	anInteger = count ifTrue: [^anInteger].
	(Incomplete count: count) raise
