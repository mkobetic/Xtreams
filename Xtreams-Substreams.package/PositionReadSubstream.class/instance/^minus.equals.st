"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-= anInteger
	self isPositionable ifFalse: [^super -= anInteger].
	position := self length - anInteger max: 0.
	^source -= anInteger