printing
streamingPrintOn: aStream
	super streamingPrintOn: aStream.
	aStream
		space;
		write: '#';
		write: block method homeMethod selector;
		write: ' buffered: ';
		print: buffer writeSize.
	buffer writeSize isZero ifTrue: [^self].
	aStream
		cr; tab;
		print: buffer contentsPast