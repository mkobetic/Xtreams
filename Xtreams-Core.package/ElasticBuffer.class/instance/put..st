"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
put: anObject

	self writeSize < 1 ifTrue: [self growBy: 1].
	^super put: anObject