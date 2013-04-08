"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
available
	"Return the number of elements from the current position to the end of the stream. The stream must be positionable."
	"	^	<Integer>	the number of elements available"
	"
		String new writing write: 'Hello World'; -- 5; available
	"
	^self length - self position