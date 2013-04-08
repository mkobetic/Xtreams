"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
bufferSize: aBufferSize
	cache size < aBufferSize ifTrue: [cache := String new: aBufferSize]