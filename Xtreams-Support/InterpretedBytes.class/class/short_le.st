"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
short_le

	self isBigEndian ifFalse: [ ^self short ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: false ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: false ]