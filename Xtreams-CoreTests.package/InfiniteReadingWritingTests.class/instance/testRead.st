tests - core
testRead
	self output write: #[ 1 2 3 4 ].
	self assert: (self input read: 3) = #[1 2 3].
	self assert: self input get = 4