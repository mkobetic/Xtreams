"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
terminal
	"Return the object at the bottom of the stream."
	"	^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(destination isKindOf: WriteStream)
		ifTrue: [ destination terminal ]
		ifFalse: [ destination ]