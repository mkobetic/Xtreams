"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
