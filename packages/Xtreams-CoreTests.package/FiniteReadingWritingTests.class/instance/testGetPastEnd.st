tests - core
testGetPastEnd
	self output put: 120.
	self output close.
	self assert: self input get = 120.
	self should: [self input get] raise: Incomplete