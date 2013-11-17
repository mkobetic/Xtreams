"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: aPosition
	| available |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: self length.
	destination seekTo: available from: #begin.
	position := available.
	available = aPosition ifTrue: [ ^aPosition ].
	(Incomplete count: available) raise
