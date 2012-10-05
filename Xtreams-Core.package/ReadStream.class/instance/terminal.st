accessing
terminal
	"Return the object at the bottom of the stream."
	"	^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(source isKindOf: XTReadStream)
		ifTrue: [ source terminal ]
		ifFalse: [ source ]