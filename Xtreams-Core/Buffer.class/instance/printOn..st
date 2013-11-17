"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: printing
"
printOn: aStream
	| stream |
	stream := String new writing.
	self streamingPrintOn: stream.
	aStream nextPutAll: stream conclusion
