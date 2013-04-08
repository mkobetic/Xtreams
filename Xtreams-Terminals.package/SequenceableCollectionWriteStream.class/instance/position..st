"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
position: aPosition
	aPosition < 0 ifTrue: [ Incomplete zero raise ].
	position := aPosition.
	^position