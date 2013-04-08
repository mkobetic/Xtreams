"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
atEnd
	" Are there any more elements after current position. The stream must be positionable."
	"	^		<Boolean>"
	"
		'Hello' reading -= 0; atEnd
	"
	"some non-positionables answer position and length, c.f. limiting:"
	self isPositionable ifFalse: [self error: 'This stream is not positionable.'].
	^self position = self length