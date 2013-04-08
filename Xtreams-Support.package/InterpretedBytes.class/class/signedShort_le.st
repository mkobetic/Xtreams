"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
signedShort_le

	self isBigEndian ifFalse: [ ^self signedShort ].
	^Array with: 2 with: Array with: [:b :i | b shortAt: i bigEndian: false ] with: [:b :i :o | b shortAt: i put: o bigEndian: false ]