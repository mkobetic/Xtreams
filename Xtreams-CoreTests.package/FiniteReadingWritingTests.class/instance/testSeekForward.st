tests - seeking
testSeekForward

	self output write: #[ 1 2 3 4 ]; close.
	self assert: (self input ++ 2) = 2.
	self assert: self input rest = #[3 4].