"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
signedChar

	^(Array with: 1 with: Array with: [:b :i | b signedByteAt: i] with: [:b :i :o | b signedByteAt: i put: o])