"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: printing
"
printOn: aStream
	| stream |
	stream := String new writing.
	self streamingPrintOn: stream.
	aStream nextPutAll: stream conclusion.
	aStream cr.
	source printOn: aStream
