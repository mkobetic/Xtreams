"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: printing
"
streamingPrintOn: aStream
	| tail head |
	super streamingPrintOn: aStream.
	tail := position min: 5.
	head := (destination size - position) min: (10 - tail).
	aStream
		write: ' position: ';
		print: position;
		write: ' size: ';
		print: destination size;
		cr; tab;
		write: (position > 5 ifTrue: ['...'] ifFalse: ['']);
		print: (destination copyFrom: position + 1 - tail to: position);
		write: '  |  ';
		print: (destination copyFrom: position + 1 to: position + head);
		write: (destination size - position > (10 - tail) ifTrue: ['...'] ifFalse: [''])
