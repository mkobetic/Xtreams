"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
conclusion
	"Close the stream and return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure> "
	self close.
	^self terminal
