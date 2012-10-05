seeking
length
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^destination fileSize