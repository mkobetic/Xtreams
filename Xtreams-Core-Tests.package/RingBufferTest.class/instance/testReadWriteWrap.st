"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testReadWriteWrap

	output := 'wwww' copy.
	buffer write: 4 from: '1234' at: 1.
	buffer read: 3 into: output at: 1.
	self assert: output = '123w'.
	self assert: buffer cache = '1234'.
	self assert: buffer readPosition = 3.
	self assert: buffer readSize = 1.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 3.
	buffer write: 1 from: 'A' at: 1.
	self assert: buffer cache = 'A234'.
	self assert: buffer readPosition = 2.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 2.
	buffer write: 2 from: 'BC' at: 1.
	self assert: buffer cache = 'ABC4'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 4.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 0.
	output := 'wwww' copy.
	buffer read: 4 into: output at: 1.
	self assert: output = '4ABC'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4