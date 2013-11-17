"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testWriteWrap

	buffer write: 3 from: '1234' at: 1.
	buffer write: 2 from: 'AB' at: 1.
	self assert: buffer cache = 'B23A'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
