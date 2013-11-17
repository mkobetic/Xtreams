"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
char

	^(Array with: 1 with: ByteArray with: [:b :i | b byteAt: i] with: [:b :i :o | b byteAt: i put: o])
