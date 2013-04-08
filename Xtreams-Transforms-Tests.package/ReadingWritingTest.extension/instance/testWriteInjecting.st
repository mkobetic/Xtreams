"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testWriteInjecting
	(self output injecting: 0 into: [:all :each | all + each])
		write: #[ 1 2 3 4 ]; close.
	self assert: (self input read: 4) = #[ 1 3 6 10 ]