"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-- anInteger
	"Seek backward by anInteger elements. The stream must be positionable."
	"	anInteger	<Integer>	The number of elements to go back by."
	"
		'hello' reading rest; -- 3; rest
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:	[self error: 'This stream is not positionable.']
		ifTrue:	[self subclassResponsibility]