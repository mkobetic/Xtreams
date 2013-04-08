"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
positioning: max
	"If necessary add a positioning layer that allows stepping back at most @max elements. Note that in this case the positioning layer employs a ring buffer of @max size to implement the ability.
	""	max		<SmallInteger>	how far back can you go
		^	<WriteStream>	a write stream with limited positionability
	""
		([ :x | Transcript space; print: x ] writing positioning: 5) write: (1 to: 10); -- 5; write: (11 to: 15); close
	"
	^self isPositionable
		ifTrue:	[self]
		ifFalse:	[PositionWriteStream on: self buffer: (RingBuffer new: max class: self contentsSpecies)]