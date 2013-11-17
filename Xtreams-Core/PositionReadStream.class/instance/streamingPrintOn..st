"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
