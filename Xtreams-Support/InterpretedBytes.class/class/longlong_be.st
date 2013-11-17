"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
longlong_be

	self isBigEndian ifTrue: [ ^self longlong ].
	^(Array with: 8 with: LongIntegerArray with: [:b :i | b unsignedLongLongAt: i bigEndian: true] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: true])