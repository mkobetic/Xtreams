"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDictionary
	| result |
	marshaling put: (Dictionary new at: 1 put: 'one'; at: #two put: 2; at: 'three' put: (4 @ 5); yourself).
	self analyse.
	result := marshaling get.
	self assert: (result at: 1) = 'one'.
	self assert: (result at: #two) = 2.
	self assert: (result at: 'three') = (4 @ 5)