"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testPut

	self output put: 1.
	self assert: self input get = 1
