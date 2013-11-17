"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testSeekForward

	self output write: #[ 1 2 3 4 ]; close.
	self assert: (self input ++ 2) = 2.
	self assert: self input rest = #[3 4].
