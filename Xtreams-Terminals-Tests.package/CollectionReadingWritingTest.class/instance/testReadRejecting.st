"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testReadRejecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input rejecting: [ :e | e even ]) read: 5) = #[ 1 3 5 7 9 ]
