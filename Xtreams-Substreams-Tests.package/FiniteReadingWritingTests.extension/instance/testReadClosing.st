"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testReadClosing
	| closing closed |
	self output write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	closed := false.
	closing := self input closing: [ closed := true ].

	self assert: (closing read: 3) = #[ 1 2 3 ].
	self assert: (closing read: 4) = #[ 4 5 6 7 ].
	self deny: closed.
	self assert: (closing read: 2) = #[ 8 9 ].
	self deny: closed.
	self should: [closing get] raise: Incomplete.
	self deny: closed.
	closing close.
	self assert: closed