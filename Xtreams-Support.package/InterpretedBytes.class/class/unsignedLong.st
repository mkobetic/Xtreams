"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
unsignedLong

	^(Array with: 4 with: "DwordArray" IntegerArray with: [:b :i | b unsignedLongAt: i] with: [:b :i :o | b unsignedLongAt: i put: o])
