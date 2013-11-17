"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
streamingPrintOn: aStream
	aStream write: self class name;
		space; write: 'data: '; print: dataLength;
		space; write: 'read: '; print: self readPosition;
		space; write: 'write: '; print: self writePosition
