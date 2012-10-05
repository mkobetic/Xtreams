tests
testClear

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer clear.
	buffer write: 4 from: 'ABCD' at: 1.
	buffer read: 4 into: output at: 1.
	self assert: output = 'ABCD'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 8