accessing - reading
get
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	readPosition := readPosition + 1.
	^cache at: readPosition