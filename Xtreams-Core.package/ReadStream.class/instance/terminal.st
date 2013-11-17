"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
terminal
	"Return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(source isKindOf: ReadStream)
		ifTrue: [ source terminal ]
		ifFalse: [ source ]