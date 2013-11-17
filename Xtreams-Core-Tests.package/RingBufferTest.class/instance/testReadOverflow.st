"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
	self assert: buffer writeSize = 4
