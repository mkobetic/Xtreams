"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testRecursion
	| value result |
	value := nil asValue.
	value value: value.
	marshaling put: value.
	self analyse.
	result := marshaling get.
	self assert: result value == result
