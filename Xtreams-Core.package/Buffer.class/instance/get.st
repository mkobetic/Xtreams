"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing - reading
"
get
	dataLength = readPosition ifTrue: [Incomplete zero raise].
	readPosition := readPosition + 1.
	^cache at: readPosition
