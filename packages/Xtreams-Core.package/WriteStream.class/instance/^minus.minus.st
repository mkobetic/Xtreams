seeking
-- anInteger
	"Seek backward by anInteger elements. The stream must be positionable."
	"	anInteger	<Integer>	The number of elements to go back by."
	"
		String new writing write: 'helio'; -- 2; write: 'lo'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:	[self error: 'This stream is not positionable.']
		ifTrue:	[self subclassResponsibility]