"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testReadEndingBlockTail
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: [:e | e = 4] inclusive: true) slicing.
	substream := ender get.
	self assert: (substream read: 4) = #[ 1 2 3 4 ].
	self should: [substream get] raise: Incomplete.
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
