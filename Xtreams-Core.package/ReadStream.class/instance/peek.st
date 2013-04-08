"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
peek
	" Explore the stream forward by one element then rewind once. The stream must be positionable."
	"	^		<Object>	result of aBlock"
	"
		'Hello' reading peek
	"
	| element |
	self isPositionable ifFalse: [ self error: 'This stream is not positionable.' ].
	element := self get.
	self -- 1.
	^element