"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		write: ' buffered: ';
		print: buffer readSize.
	buffer readSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsFuture