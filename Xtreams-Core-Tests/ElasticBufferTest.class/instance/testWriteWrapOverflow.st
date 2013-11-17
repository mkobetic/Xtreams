"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testWriteWrapOverflow

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 2 into: output at: 1.
	buffer write: 5 from: 'ABCDE' at: 1.
	buffer write: 3 from: 'XYZ' at: 1.
	self assert: (buffer cache first: 4) = 'EXYZ'.
	self assert: (buffer cache last: 4) = 'ABCD'.
	self assert: buffer cacheSize = 20.
	self assert: buffer activeSize = 11.
	self assert: buffer inactiveSize = 9.
	self assert: buffer readPosition = 1.
	self assert: buffer writePosition = 11.
	self assert: buffer readSize = 10.
	self assert: buffer writeSize = 10
