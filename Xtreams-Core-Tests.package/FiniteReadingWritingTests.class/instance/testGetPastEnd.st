"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testGetPastEnd
	self output put: 120.
	self output close.
	self assert: self input get = 120.
	self should: [self input get] raise: Incomplete