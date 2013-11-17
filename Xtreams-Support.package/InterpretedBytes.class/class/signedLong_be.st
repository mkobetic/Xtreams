"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
signedLong_be

	self isBigEndian ifTrue: [ ^self signedLong ].
	^(Array with: 4 with: SignedIntegerArray with: [:b :i | b longAt: i bigEndian: true ] with: [:b :i :o | b longAt: i put: o bigEndian: true])
