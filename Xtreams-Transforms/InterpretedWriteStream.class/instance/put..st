"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
put: anObject

	operation value: cache value: 1 value: anObject.
	destination write: elementSize from: cache at: 1.
	^anObject
