"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testClear

	| cacheSize |
	buffer write: 4 from: '1234' at: 1.
	cacheSize := buffer cacheSize.
	buffer clear.
	self assert: buffer cacheSize = cacheSize.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer writeSize = cacheSize
