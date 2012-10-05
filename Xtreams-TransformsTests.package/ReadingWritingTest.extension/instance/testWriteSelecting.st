*Xtreams-TransformsTests-transforming
testWriteSelecting
	(self output selecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 4) = #[ 2 4 6 8 ]