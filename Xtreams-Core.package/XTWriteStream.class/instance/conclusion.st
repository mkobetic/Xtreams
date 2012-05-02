accessing
conclusion
	"Close the stream and return the object at the bottom of the stream."
	"	^<Collection | Buffer | IOAccessor | BlockClosure> "
	self close.
	^self terminal