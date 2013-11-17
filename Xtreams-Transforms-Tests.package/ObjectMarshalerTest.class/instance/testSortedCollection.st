"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSortedCollection
	| sortBlock result |
	sortBlock := Kernel.Compiler evaluate: '[:a :b | a <= b]'.
	marshaling put: ((SortedCollection sortBlock: sortBlock) add: 5; add: 4; add: 1; add: 3; add: 2; yourself).
	self analyse.
	result := marshaling get.
	self assert: result asArray = #(1 2 3 4 5).
	result add: 1.5.
	self assert: result asArray = #(1 1.5 2 3 4 5)
