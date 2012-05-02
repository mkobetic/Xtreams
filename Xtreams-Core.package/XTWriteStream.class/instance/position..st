seeking
position: anInteger
	"Change current position of the stream to anInteger. The stream must be positionable."
	"	anInteger	<Integer>	current position of the stream."
	"
		'Hello Would' copy writing position: 6; write: 'World'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:	[self error: 'This stream is not positionable.']
		ifTrue:	[self subclassResponsibility]