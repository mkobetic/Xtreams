"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testInsert
	self output write: #[ 1 2 3 4 7 8 9 0 ].
	self output -- 4.
	self output insert: #[ 5 6 ].
	self output -= 0. "Have to seek to the end otherwise output gets truncated when we close it"
	self assert: (self input read: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ]
