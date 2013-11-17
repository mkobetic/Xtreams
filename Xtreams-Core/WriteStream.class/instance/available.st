"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
available
	"Return the number of elements from the current position to the end of the stream. The stream must be positionable."
	"       ^       <Integer>       the number of elements available"
	"
		String new writing write: 'Hello World'; -- 5; available
	"
	^self length - self position
