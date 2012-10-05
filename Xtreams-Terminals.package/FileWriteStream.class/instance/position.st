seeking
position
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^position