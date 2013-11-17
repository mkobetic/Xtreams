"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteSelecting
	(self output selecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 4) = #[ 2 4 6 8 ]
