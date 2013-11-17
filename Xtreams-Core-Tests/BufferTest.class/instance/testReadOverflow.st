"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testReadOverflow

	output := 'wwwwww' copy.
	buffer write: 4 from: '1234' at: 1.
	self should: [buffer read: 6 into: output at: 1] raise: Incomplete.
	self assert: output = '1234ww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 8
