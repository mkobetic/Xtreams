tests
testTrim

	output := 'wwww' copy.
	buffer write: 8 from: '12345678' at: 1.
	buffer read: 2 into: output at: 1.
	buffer writeSkip: -2.
	buffer trim.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	buffer read: 4 into: output at: 1.
	self assert: output = '3456'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4