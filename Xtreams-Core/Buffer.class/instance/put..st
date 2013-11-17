"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - writing
"
put: anObject

	writePosition < cache size ifFalse: [self growBy: 1].

	cache at: writePosition + 1 put: anObject.
	writePosition := writePosition + 1.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject
