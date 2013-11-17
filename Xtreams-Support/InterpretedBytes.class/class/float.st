"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: type descriptions
"
float

	^(Array with: 4 with: "FloatArray" Array with: [:b :i | b floatAt: i] with: [:b :i :o | b floatAt: i put: o])
