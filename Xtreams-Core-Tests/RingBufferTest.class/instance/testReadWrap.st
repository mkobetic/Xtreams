"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testReadWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 3 from: 'ABC' at: 1.
	output := 'wwww' copy.
	buffer read: 4 into: output at: 1.
	self assert: output = '4ABC'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
