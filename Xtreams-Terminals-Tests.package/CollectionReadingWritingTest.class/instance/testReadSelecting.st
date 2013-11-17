"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testReadSelecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input selecting: [ :e | e even ]) read: 4) = #[ 2 4 6 8 ]
