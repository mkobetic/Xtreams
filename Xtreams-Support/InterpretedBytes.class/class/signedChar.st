"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
signedChar

	^(Array with: 1 with: Array with: [:b :i | b signedByteAt: i] with: [:b :i :o | b signedByteAt: i put: o])
