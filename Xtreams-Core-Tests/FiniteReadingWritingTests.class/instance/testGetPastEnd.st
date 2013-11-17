"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testGetPastEnd
	self output put: 120.
	self output close.
	self assert: self input get = 120.
	self should: [self input get] raise: Incomplete
