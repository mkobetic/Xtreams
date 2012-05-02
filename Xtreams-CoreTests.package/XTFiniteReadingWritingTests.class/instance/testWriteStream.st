tests - core
testWriteStream
	| data |
	data := #[ 1 2 3 4 ] reading.
	self assert: (self output write: data) = 4.
	self shouldnt: [ self output write: data ] raise: Incomplete.
	self output close.
	self assert: (self input read: 4) = #[ 1 2 3 4 ].
	self should: [self input get] raise: Incomplete