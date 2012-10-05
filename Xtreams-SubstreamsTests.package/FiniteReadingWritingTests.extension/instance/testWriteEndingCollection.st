*Xtreams-SubstreamsTests
testWriteEndingCollection
	| ender |
	ender := (self output ending: #[ 1 2 3 ]) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 7) = #[ 0 1 1 2 4 5 6 ].
	self should: [self input get] raise: Incomplete