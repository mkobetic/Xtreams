"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: aPosition
	| available |
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	available := aPosition min: source activeSize.
	source readPosition: available.
	available = aPosition ifTrue: [^aPosition ].
	(Incomplete count: available) raise
