"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
position
	"Return current position of the stream. The stream must be positionable."
	"       ^       <Integer>       current position of the stream."
	"
		'Hello World' copy writing -= 5; position
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]