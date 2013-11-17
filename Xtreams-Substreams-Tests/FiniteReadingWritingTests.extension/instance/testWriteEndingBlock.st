"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testWriteEndingBlock
	| ender |
	ender := (self output ending: [:e | e = 4]) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
