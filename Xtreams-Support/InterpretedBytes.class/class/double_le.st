"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
double_le

	self isBigEndian ifFalse: [ ^self double ].
	^(Array with: 8 with: "DoubleArray" Array with: [:b :i | b doubleAt: i bigEndian: false] with: [:b :i :o | b doubleAt: i put: o bigEndian: false])