"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
positioning
	"If necessary add positioning layer. Note that positioning layer employs buffering to implement the ability. In this case the buffering strategy will grow the buffer up to the full size of the written content if not flushed appropriately. Other buffer types might be more suitable for specific circumstances, see #positioning: as an alternative example."
	"	^	<WriteStream>	a positionable write stream
	""
		[ :x | Transcript space; print: x ] writing positioning write: (1 to: 10); -- 5; write: (11 to: 15); close
	"
	^self isPositionable
		ifTrue:	[self]
		ifFalse:	[PositionWriteStream on: self]