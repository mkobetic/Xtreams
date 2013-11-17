"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
unsignedLong_le

	self isBigEndian ifFalse: [ ^self unsignedLong ].
	^(Array with: 4 with: "DwordArray" IntegerArray with: [:b :i | b unsignedLongAt: i bigEndian: false ] with: [:b :i :o | b unsignedLongAt: i put: o bigEndian: false])
