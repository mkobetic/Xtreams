*Xtreams-TransformsTests-transforming
testReadRejecting
	self output write: #[ 1 2 3 4 5 6 7 8 9 ].
	self assert: ((self input rejecting: #even) read: 5) = #[ 1 3 5 7 9 ]