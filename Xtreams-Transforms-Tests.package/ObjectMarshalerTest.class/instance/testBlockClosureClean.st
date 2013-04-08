"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testBlockClosureClean
	marshaling put: [].
	marshaling put: [:x :y | x + y].
	self analyse.
	self assert: marshaling get value = nil.
	self assert: (marshaling get value: 2 value: 3) = 5