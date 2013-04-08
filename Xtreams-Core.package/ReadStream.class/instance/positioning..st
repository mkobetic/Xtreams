"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
positioning: max
	"If necessary add a positioning layer that allows stepping back at most @max elements. Note that in this case the positioning layer employs a ring buffer of @max size to implement the positioning ability."
	"	max		<SmallInteger>	how far back can you go
		^<ReadStream>	a read stream with limited positionability
	""
		| x | x := 0. ([ x := x + 1 ] reading positioning: 5) ++ 10; -- 4; get
	"
	^self isPositionable
		ifTrue:	[self]
		ifFalse:	[PositionReadStream on: self buffer: (RingBuffer new: max class: self contentsSpecies)]