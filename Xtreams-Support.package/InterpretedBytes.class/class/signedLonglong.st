"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
signedLonglong

	^(Array with: 8 with: SignedLongIntegerArray with: [:b :i | b longLongAt: i] with: [:b :i :o | b longLongAt: i put: o])
