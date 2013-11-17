"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testReadIntoAt
	| result |
	self output write: #[ 1 2 3 4 ]; close.
	result := ByteArray new: 8 withAll: 255.
	self input read: 3 into: result at: 3.
	self assert: result = #[255 255 1 2 3 255 255 255].
	self input read: 1 into: result at: 6.
	self assert: result = #[255 255 1 2 3 4 255 255].
	self should: [self input get] raise: Incomplete.
	self should: [self input read: 3 into: result at: 5] raise: Incomplete.
	self assert: result = #[255 255 1 2 3 4 255 255].
