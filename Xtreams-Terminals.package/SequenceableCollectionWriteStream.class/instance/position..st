"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: aPosition
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition min: self length.
	position = aPosition ifTrue: [^aPosition].
	(Incomplete count: position) raise
