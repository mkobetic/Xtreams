"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
tlsUint24

	^Array
		with: 3
		with: Array
		with: [ :b :i | ((((b byteAt: i) bitShift: 8) + (b byteAt: i + 1)) bitShift: 8) + (b byteAt: i + 2) ]
		with: [ :b :i :o |
			b       byteAt: i put: (o bitShift: -16);
				byteAt: i + 1 put: ((o bitShift: -8) bitAnd: 255);
				byteAt: i + 2 put: (o bitAnd: 255) ]
