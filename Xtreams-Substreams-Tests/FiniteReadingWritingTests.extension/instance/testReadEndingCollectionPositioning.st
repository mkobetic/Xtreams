"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testReadEndingCollectionPositioning
	| substream ender |
	self output write: #[ 0 1 1 2 1 2 3 4 5 6 ]; close.
	ender := (self input ending: #[ 1 2 3 ]) slicing.
	substream := ender get.
	substream ++ 3.
	self assert: substream get = 2.
	self should: [substream ++ 3] raise: Incomplete.
	self should: [substream -- 2] raise: Error. "not positionable"
	substream := ender get.
	self assert: substream get = 4.
	substream -= 0.
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
