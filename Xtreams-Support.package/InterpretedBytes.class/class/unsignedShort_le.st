"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
unsignedShort_le

	self isBigEndian ifFalse: [ ^self unsignedShort ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: false ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: false ]
