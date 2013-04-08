"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testWriteSelecting
	(self output selecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 4) = #[ 2 4 6 8 ]