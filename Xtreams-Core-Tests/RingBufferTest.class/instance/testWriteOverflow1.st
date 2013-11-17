"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testWriteOverflow1

	buffer write: 1 from: '1234' at: 1.
	buffer write: 5 from: 'ABCDE' at: 1.
	self assert: buffer cache = 'BCDE'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0
