"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testReadInjecting
	self output write: #[ 1 2 3 4 ].
	self assert: ((self input injecting: 0 into: [:all :each | all + each]) read: 4) = #[ 1 3 6 10 ]
