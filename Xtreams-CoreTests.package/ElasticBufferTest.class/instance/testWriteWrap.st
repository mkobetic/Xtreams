tests
testWriteWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	buffer write: 6 from: 'ABCDEF' at: 1.
	self assert: buffer cache = 'EF34ABCD'.
	self assert: buffer cacheSize = 8.
	self assert: buffer activeSize = 8.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 8.
	self assert: buffer readSize = 8.
	self assert: buffer writeSize = 0