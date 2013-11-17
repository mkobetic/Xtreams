"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteObject
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 0.
	self assert: buffer inactiveSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 0.
	self assert: buffer readSize = 0.
	self assert: buffer writeSize = 4.

	buffer put: $1.
	self assert: buffer cache first = $1.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 1.
	self assert: buffer inactiveSize = 3.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 1.
	self assert: buffer readSize = 1.
	self assert: buffer writeSize = 3.
	buffer put: $2; put: $3; put: $4.
	self assert: buffer cache = '1234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer inactiveSize = 0.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
	self assert: buffer writeSize = 0.
	buffer put: $5.
	self assert: buffer cache = '5234'.
	self assert: buffer cacheSize = 4.
	self assert: buffer activeSize = 4.
	self assert: buffer readPosition = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer readSize = 4.
