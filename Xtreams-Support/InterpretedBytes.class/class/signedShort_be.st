"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
signedShort_be

	self isBigEndian ifTrue: [ ^self signedShort ].
	^Array with: 2 with: SignedWordArray with: [:b :i | b shortAt: i bigEndian: true ] with: [:b :i :o | b shortAt: i put: o bigEndian: true ]
