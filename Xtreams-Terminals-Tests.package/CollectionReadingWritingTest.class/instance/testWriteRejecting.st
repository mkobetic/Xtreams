"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testWriteRejecting
	(self output rejecting: [ :e | e even ] ) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 5) = #[ 1 3 5 7 9 ]
