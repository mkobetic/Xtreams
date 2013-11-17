"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
length
	"Return total length of the stream. The stream must be positionable."
	"       ^       <Integer>       the total number of elements in the stream. (position + available)"
	"
		'Hello' reading read: 2; length
	"
	"Subclasses should reimplement this method if the stream is positionable."
	^self isPositionable
		ifFalse:        [self error: 'This stream is not positionable.']
		ifTrue: [self subclassResponsibility]
