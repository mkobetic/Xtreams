"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
