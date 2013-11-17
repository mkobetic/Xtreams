"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingWrite: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingWriteInto: aWriteStream].
	^anInteger
