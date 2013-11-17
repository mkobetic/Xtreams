"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
