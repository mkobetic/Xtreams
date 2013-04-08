"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^position