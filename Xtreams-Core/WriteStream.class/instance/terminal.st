"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
terminal
	"Return the object at the bottom of the stream."
	"       ^<Collection | Buffer | IOAccessor | BlockClosure>
	"
	^(destination isKindOf: WriteStream)
		ifTrue: [ destination terminal ]
		ifFalse: [ destination ]
