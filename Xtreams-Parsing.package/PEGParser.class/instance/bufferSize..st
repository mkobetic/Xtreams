initialize-release
bufferSize: aBufferSize
	cache size < aBufferSize ifTrue: [cache := String new: aBufferSize]