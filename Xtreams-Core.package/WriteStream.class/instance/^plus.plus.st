"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
++ anInteger
	"Seek forward by anInteger elements. The stream must be positionable."
	"	anInteger	<Integer>	the number of elements to go forward by.
		^<Integer>	the number of elements actually skipped
	"
	"
		'Hello Would' copy writing ++ 6; write: 'World'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:	[Incomplete zero raise]
		ifTrue:	[self subclassResponsibility]