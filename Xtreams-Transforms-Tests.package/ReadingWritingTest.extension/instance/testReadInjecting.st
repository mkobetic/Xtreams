"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testReadInjecting
	self output write: #[ 1 2 3 4 ].
	self assert: ((self input injecting: 0 into: [:all :each | all + each]) read: 4) = #[ 1 3 6 10 ]