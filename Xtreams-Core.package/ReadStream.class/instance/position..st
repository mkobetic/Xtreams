seeking
position: anInteger
	"Change position of the stream to anInteger. The stream must be positionable."
	"	anInteger	<Integer>	the position to set the stream at.
		^<Integer>	the position the stream was set to
	""
		'Hello' reading position: 2; rest
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:	[self error: 'This stream is not positionable.']
		ifTrue:	[self subclassResponsibility]