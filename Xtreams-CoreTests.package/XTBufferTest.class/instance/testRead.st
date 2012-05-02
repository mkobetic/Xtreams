tests
testRead

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	self assert: output = '1www'.
	self assert: buffer readPosition = 1.
	self assert: buffer readSize = 3.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 5.
	buffer read: 3 into: output at: 2.
	self assert: output = '1234'.
	self assert: buffer readPosition = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 8