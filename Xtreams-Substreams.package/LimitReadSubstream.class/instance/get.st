"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	position = limit ifTrue: [Incomplete zero raise].
	^super get