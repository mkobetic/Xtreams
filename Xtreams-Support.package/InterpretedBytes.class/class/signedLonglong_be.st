"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
signedLonglong_be

	self isBigEndian ifTrue: [ ^self signedLonglong ].
	^(Array with: 8 with: SignedLongIntegerArray with: [:b :i | b longLongAt: i bigEndian: true] with: [:b :i :o | b longLongAt: i put: o bigEndian: true])
