"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
positioning
	"If necessary add positioning layer. Note that positiong layer employs buffering to implement the positioning ability. The default buffering strategy will grow the buffer up to the full size of the underlying stream if not released. Consequently other Buffer types might be more suitable for specific circumstances, e.g. if only last n elements need to be buffered, a fixed size RingBuffer can be substitued with #buffer: accessor."
	"       ^       <ReadStream>    a positionable read stream
	""
		[ Time now ] reading positioning ++ 3; -- 2; get
	"
	^self isPositionable
		ifTrue: [self]
		ifFalse:        [PositionReadStream on: self]
