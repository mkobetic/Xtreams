"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	position = limit ifTrue: [Incomplete zero raise].
	^super get
