"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testReadEndingCollectionTail
	| substream ender |
	self output write: #[ 0 1 1 2 1 2 3 4 5 6 ]; close.
	ender := (self input ending: #[ 1 2 3 ] inclusive: true) slicing.
	substream := ender get.
	self assert: (substream read: 7) = #[ 0 1 1 2 1 2 3 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 3) = #[ 4 5 6 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
