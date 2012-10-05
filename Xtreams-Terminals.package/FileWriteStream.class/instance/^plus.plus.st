seeking
++ anInteger
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
	position := position + anInteger.
	destination seekTo: position.
	^anInteger