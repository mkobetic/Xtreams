"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-- anInteger
	"Seek backward by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go back by."
	"
		'hello' reading rest; -- 3; rest
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
