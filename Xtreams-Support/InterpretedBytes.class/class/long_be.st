"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
long_be

	self isBigEndian ifTrue: [ ^self long ].
	^(Array with: 4 with: "DwordArray" IntegerArray with: [:b :i | b unsignedLongAt: i bigEndian: true ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: true])
