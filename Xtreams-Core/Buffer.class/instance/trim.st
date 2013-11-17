"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: compressing
"
trim
	cache := cache copyFrom: readPosition + 1 to: writePosition.
	readPosition := 0.
	dataLength := writePosition := cache size
