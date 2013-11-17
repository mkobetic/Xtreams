"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - writing
"
put: anObject

	self writeSize < 1 ifTrue: [self growBy: 1].
	^super put: anObject
