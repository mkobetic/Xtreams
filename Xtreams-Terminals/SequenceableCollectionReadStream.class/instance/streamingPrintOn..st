"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: printing
"
streamingPrintOn: aStream
	| tail head |
	super streamingPrintOn: aStream.
	tail := position min: 5.
	head := (source size - position) min: (10 - tail).
	aStream
		write: ' position: ';
		print: position;
		write: ' size: ';
		print: source size;
		cr; tab;
		write: (position > 5 ifTrue: ['...'] ifFalse: ['']);
		print: (source copyFrom: position + 1 - tail to: position);
		write: '  |  ';
		print: (source copyFrom: position + 1 to: position + head);
		write: (source size - position > (10 - tail) ifTrue: ['...'] ifFalse: [''])
