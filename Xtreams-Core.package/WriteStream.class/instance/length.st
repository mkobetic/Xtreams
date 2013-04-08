"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
length
	"Return total length of the stream. The stream must be positionable."
	"	^	<Integer>	the total number of elements in the stream. (position + available)"
	"
		'Hello World' copy writing ++ 5; length
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:	[self error: 'This stream is not positionable.']
		ifTrue:	[self subclassResponsibility]