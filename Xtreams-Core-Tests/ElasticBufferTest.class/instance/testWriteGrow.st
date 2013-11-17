"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testWriteGrow

	self assert: buffer cacheSize = 0.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 0.
	buffer write: 4 from: '1234' at: 1.
	self assert: (buffer cache first: 4) = '1234'.
	self assert: buffer cacheSize = 8.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 4
