"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWrite: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingWriteInto: aWriteStream].
	^anInteger