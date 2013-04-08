"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testTrim

	output := 'wwww' copy.
	buffer write: 3 from: '1234' at: 1.
	buffer read: 1 into: output at: 1.
	buffer writeSkip: -1.
	buffer trim.
	self assert: buffer cacheSize = 2.
	self assert: buffer cache = '23'.
	self assert: buffer readPosition = 0.
	self assert: buffer readSize = 2.
	self assert: buffer writePosition = 2.
	self assert: buffer writeSize = 0