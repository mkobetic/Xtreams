seeking
position: aPosition
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	destination seekTo: aPosition.
	position := aPosition.
	^position