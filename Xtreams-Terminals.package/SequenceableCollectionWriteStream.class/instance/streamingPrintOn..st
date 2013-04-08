"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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