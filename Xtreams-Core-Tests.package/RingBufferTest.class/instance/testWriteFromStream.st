"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteFromStream

	buffer write: 3 from: '1234' reading.
	buffer write: 2 from: 'ABCDE' reading.
	self assert: buffer cache = 'B23A'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0.
	buffer write: 'abcdefghijklmnopqr' reading.
	self assert: buffer cache = 'opqr'.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0.