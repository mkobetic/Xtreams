tests
testWriteOverflow0

	buffer write: 1 from: '1234' at: 1.
	buffer write: 4 from: 'ABCD' at: 1.
	self assert: buffer cache = 'ABCD'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0