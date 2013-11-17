"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - reading
"
get
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	readPosition := readPosition + 1.
	^cache at: readPosition
