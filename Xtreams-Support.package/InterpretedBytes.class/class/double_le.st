"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
double_le
	
	self isBigEndian ifFalse: [ ^self double ].
	^(Array with: 8 with: "DoubleArray" Array with: [:b :i | b doubleAt: i bigEndian: false] with: [:b :i :o | b doubleAt: i put: o bigEndian: false])