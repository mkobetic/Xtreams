"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testRest

	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input rest = #[1 2 3 4].
	self assert: self input rest = #[]
