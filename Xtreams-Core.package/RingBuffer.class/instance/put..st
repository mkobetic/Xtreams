"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - writing
"
put: anObject
	| write |

	write := (dataPosition + writePosition) \\ cache size.
	cache at: write + 1 put: anObject.

	self privateWrapDataPosition: 1.
	writePosition := (writePosition + 1) min: cache size.
	writePosition > dataLength ifTrue: [dataLength := writePosition].
	^anObject
