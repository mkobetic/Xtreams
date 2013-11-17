"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
++ anInteger
	"Seek forward by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       the number of elements to go forward by.
		^<Integer>      the number of elements actually skipped
	"
	"
		'Hello Would' copy writing ++ 6; write: 'World'; close; destination
	"
	"Subclasses should reimplement this method if the stream is positionable."
	self isPositionable
		ifFalse:        [Incomplete zero raise]
		ifTrue: [self subclassResponsibility]
