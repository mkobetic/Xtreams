"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^position
