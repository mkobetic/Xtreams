"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testPut

	self output put: 1.
	self assert: self input get = 1
