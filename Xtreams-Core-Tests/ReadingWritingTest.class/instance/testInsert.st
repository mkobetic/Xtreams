"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - core
"
testInsert
	self output write: #[ 1 2 3 4 7 8 9 0 ].
	[self output -- 4] on: Error do: [self deny: self output isPositionable].
	self assert: (self output insert: #[ 5 6 ]) = 2.
	self input isPositionable
		ifTrue: [self assert: (self input read: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ]]
		ifFalse:        [self assert: (self input read: 10) = #[ 1 2 3 4 7 8 9 0 5 6 ]]
