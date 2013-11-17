"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	position = limit ifTrue: [Incomplete zero raise].
	^super put: anObject
