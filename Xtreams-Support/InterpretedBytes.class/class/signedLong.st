"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
signedLong

	^(Array with: 4 with: SignedIntegerArray with: [:b :i | b longAt: i] with: [:b :i :o | b longAt: i put: o])