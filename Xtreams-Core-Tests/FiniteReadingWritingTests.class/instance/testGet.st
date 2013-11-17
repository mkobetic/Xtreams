"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testGet
	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input get = 1.
	self assert: self input get = 2.
	self assert: self input get = 3.
	self assert: self input get = 4.
	self should: [self input get] raise: Incomplete
