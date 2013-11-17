"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testClear

	buffer write: 4 from: '1234' at: 1.
	buffer clear.
	self assert: buffer cacheSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer writeSize = 0
