"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
++ anInteger
	| count |
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	count := self available min: anInteger.
	position := position + count.
	destination seekTo: position from: #begin.
	count < anInteger ifTrue: [(Incomplete count: count) raise].
	^anInteger
