"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testReadWriteFirstHalf

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	self assert: output = '12ww'.
	self assert: buffer cache = '1234'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2.
	buffer write: 2 from: 'AB' at: 1.
	self assert: buffer cache = 'AB34'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	output := 'wwww' copy.
	buffer read: 2 into: output at: 1.
	self assert: output = '34ww'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2
