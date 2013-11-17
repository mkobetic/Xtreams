"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
conclusion
	"Close the stream and return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure> "
	self close.
	^self terminal
