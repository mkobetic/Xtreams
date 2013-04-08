"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - reading
"
get
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	readPosition := readPosition + 1.
	^cache at: readPosition