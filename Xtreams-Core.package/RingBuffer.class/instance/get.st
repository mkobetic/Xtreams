"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - reading
"
get
	| read |
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	read := (dataPosition + readPosition) \\ cache size.
	readPosition := readPosition + 1.
	^cache at: read + 1