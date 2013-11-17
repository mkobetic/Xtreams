"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <WriteStream>   a positionable read stream
	""
		[ :x | Transcript space; print: x ] writing positioning write: (1 to: 10); -- 5; write: (11 to: 15); close
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionWriteStream on: self]
