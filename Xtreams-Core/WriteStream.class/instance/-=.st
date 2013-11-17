"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
-= anInteger
	"Seek backwards from the end of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       The number of elements to go back by.
		^<Integer>      the number of elements actually skipped"
	"
		'Hello Would' copy writing -= 3; write: 'rld'; close; terminal
	"
	| available |
	available := anInteger min: self length.
	self position: self length - available.
	available = anInteger ifTrue: [ ^anInteger ].
	^(Incomplete count: available) raise
