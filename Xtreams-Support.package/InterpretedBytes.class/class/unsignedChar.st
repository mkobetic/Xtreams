"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
unsignedChar

	^(Array with: 1 with: ByteArray with: [:b :i | b byteAt: i] with: [:b :i :o | b byteAt: i put: o])