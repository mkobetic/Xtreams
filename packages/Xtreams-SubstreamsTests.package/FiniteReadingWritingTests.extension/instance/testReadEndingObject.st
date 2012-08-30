*Xtreams-SubstreamsTests
testReadEndingObject
	| substream ender |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	ender := (self input ending: 4) slicing.
	substream := ender get.
	self assert: (substream read: 3) = #[ 1 2 3 ].
	self should: [substream get] raise: Incomplete.
	substream := ender get.
	self assert: (substream read: 5) = #[ 5 6 7 8 9 ].
	self should: [substream get] raise: Incomplete.
	self should: [ender get] raise: Incomplete