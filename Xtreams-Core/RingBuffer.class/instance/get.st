"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing - reading
"
get
	| read |
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	read := (dataPosition + readPosition) \\ cache size.
	readPosition := readPosition + 1.
	^cache at: read + 1
