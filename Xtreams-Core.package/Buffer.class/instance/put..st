"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
put: anObject

	writePosition < cache size ifFalse: [self growBy: 1].

	cache at: writePosition + 1 put: anObject.
	writePosition := writePosition + 1.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject
