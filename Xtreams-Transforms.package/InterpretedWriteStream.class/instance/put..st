"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject

	operation value: cache value: 1 value: anObject.
	destination write: elementSize from: cache at: 1.
	^anObject
