"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-= anInteger
	"Seek backwards from the end of the stream by anInteger elements. The stream must be positionable."
	"       anInteger       <Integer>       number of elements to go back by
		^<Integer>      number of elements actually skipped
	""
		'Hello' reading -= 3; rest
	"
	| available |
	(self isPositionable not and: [anInteger isZero]) ifTrue:
		["If we are attempting to skip to end and the stream is not positionable, skip forward until we hit an incomplete"
		[[self ++ SmallInteger maxVal] repeat] on: Incomplete do: [].
		^0 ].
	available := anInteger min: self length.
	self position: self length - available.
	available = anInteger ifTrue: [^anInteger].
	^(Incomplete count: available) raise
