"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteEndingCollectionTail
	| ender |
	ender := (self output ending: #[ 1 2 3 ] inclusive: true) slicing.
	self should: [ ender get write: #[ 0 1 1 2 1 2 3 4 5 6 ] ] raise: Incomplete.
	self shouldnt: [ ender get write: #[ 4 5 6 ] ] raise: Incomplete.
	ender close.
	self assert: (self input read: 10) = #[ 0 1 1 2 1 2 3 4 5 6 ].
	self should: [self input get] raise: Incomplete
