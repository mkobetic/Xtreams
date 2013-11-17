"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteEndingObject
	| ender |
	ender := (self output ending: 4) slicing.
	self should: [ ender get write: #[ 1 2 3 4 5 6 7 8 9 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 5 6 7 8 9 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 8) = #[ 1 2 3 5 6 7 8 9 ].
	self should: [self input get] raise: Incomplete
