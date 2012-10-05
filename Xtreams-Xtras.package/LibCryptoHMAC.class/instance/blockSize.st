accessing
blockSize
	
	^algorithm
		ifNil: [0]
		ifNotNil: [algorithm block_size]