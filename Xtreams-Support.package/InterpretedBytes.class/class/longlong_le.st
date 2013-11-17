"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
longlong_le

	self isBigEndian ifFalse: [ ^self longlong ].
	^(Array with: 8 with: LongIntegerArray with: [:b :i | b unsignedLongLongAt: i bigEndian: false] with: [:b :i :o | b unsignedLongLongAt: i put: o bigEndian: false])
