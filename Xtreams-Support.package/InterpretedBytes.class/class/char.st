"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
char

	^(Array with: 1 with: ByteArray with: [:b :i | b byteAt: i] with: [:b :i :o | b byteAt: i put: o])