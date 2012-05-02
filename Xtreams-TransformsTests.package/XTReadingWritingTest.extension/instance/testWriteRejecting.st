*Xtreams-TransformsTests-transforming
testWriteRejecting
	(self output rejecting: #even) write: #[ 1 2 3 4 5 6 7 8 9 ]; close.
	self assert: (self input read: 5) = #[ 1 3 5 7 9 ]