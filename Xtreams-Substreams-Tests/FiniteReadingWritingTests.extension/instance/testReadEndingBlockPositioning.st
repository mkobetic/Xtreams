"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testReadEndingBlockPositioning
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: [:e | e = 4]) slicing.
	substream := ender get.
	substream ++ 2.
	self assert: substream get = 3.
	self should: [substream ++ 3] raise: Incomplete.
	self should: [substream -- 2] raise: Error. "not positionable"
	substream := ender get.
	self assert: substream get = 5.
	substream -= 0.
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete
