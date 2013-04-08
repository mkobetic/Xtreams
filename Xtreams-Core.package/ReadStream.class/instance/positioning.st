"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
positioning
	"If necessary add positioning layer. Note that positioning layer employs buffering to implement the ability. In this case the buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Other buffer types might be more suitable for specific circumstances, see #positioning: as an alternative example."
	"	^	<ReadStream>	a positionable read stream
	""
		[ Time now ] reading positioning ++ 3; -- 2; get
	"
	^self isPositionable
		ifTrue:	[self]
		ifFalse:	[PositionReadStream on: self]