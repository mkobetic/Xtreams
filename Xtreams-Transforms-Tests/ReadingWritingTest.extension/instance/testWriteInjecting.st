"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - transforming
"
testWriteInjecting
	(self output injecting: 0 into: [:all :each | all + each])
		write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 4) = #[ 1 3 6 10 ]
