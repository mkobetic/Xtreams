accessing - writing
put: anObject

	writePosition < cache size ifFalse: [self growBy: 1].

	cache at: writePosition + 1 put: anObject.
	writePosition := writePosition + 1.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject