accessing - writing
put: anObject

	self writeSize < 1 ifTrue: [self growBy: 1].
	^super put: anObject