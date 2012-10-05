tests
testReadWrap

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 6 from: 'ABCDEF' at: 1.
	output := 'wwwwww' copy.
	buffer read: 6 into: output at: 1.
	self assert: output = '4ABCDE'.
	self assert: buffer readPosition = 7.
	self assert: buffer readSize = 1.
	self assert: buffer writePosition = 8.
	self assert: buffer writeSize = 7