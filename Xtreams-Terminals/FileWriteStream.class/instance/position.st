"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^position