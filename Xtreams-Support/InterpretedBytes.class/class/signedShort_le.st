"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
signedShort_le

	self isBigEndian ifFalse: [ ^self signedShort ].
	^Array with: 2 with: SignedWordArray with: [:b :i | b shortAt: i bigEndian: false ] with: [:b :i :o | b shortAt: i put: o bigEndian: false ]
