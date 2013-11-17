"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testReadClosing
	| closing closed |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	closed := 0.
	closing := (self input closing: [ closed := closed + 1 ]) slicing.

	self assert: (closing get read: 3) = #[ 1 2 3 ].
	self assert: (closing get read: 4) = #[ 4 5 6 7 ].
	self assert: closed = 1.
	self assert: (closing get read: 2) = #[ 8 9 ].
	self assert: closed = 2.
	self should: [closing get get] raise: Incomplete.
	self assert: closed = 3.
	self should: [closing get] raise: Incomplete
