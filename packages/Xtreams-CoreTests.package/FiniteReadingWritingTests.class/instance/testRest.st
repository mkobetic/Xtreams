tests - core
testRest

	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input rest = #[1 2 3 4].
	self assert: self input rest = #[]