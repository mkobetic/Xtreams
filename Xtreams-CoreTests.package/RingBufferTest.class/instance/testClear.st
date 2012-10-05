tests
testClear

	| cacheSize |
	buffer write: 4 from: '1234' at: 1.
	cacheSize := buffer cacheSize.
	buffer clear.
	self assert: buffer cacheSize = cacheSize.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer writeSize = cacheSize