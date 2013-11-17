"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testInsert
	self output write: #[ 1 2 3 4 7 8 9 0 ].
	[self output -- 4] on: Error do: [self deny: self output isPositionable].
	self assert: (self output insert: #[ 5 6 ]) = 2.
	self input isPositionable
		ifTrue: [self assert: (self input read: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ]]
		ifFalse:        [self assert: (self input read: 10) = #[ 1 2 3 4 7 8 9 0 5 6 ]]
