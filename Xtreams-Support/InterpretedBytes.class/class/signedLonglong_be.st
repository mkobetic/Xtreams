"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
signedLonglong_be

	self isBigEndian ifTrue: [ ^self signedLonglong ].
	^(Array with: 8 with: SignedLongIntegerArray with: [:b :i | b longLongAt: i bigEndian: true] with: [:b :i :o | b longLongAt: i put: o bigEndian: true])
