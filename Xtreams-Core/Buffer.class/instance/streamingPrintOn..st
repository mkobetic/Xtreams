"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: printing
"
streamingPrintOn: aStream
	aStream write: self class name;
		space; write: 'data: '; print: dataLength;
		space; write: 'read: '; print: self readPosition;
		space; write: 'write: '; print: self writePosition
