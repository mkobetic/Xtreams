"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testObject

	| result |
	result := JSON decode: '{ "one" : 1, "two" : 2 }'.
	self assert: result size = 2.
	self assert: (result at: #one) = 1.
	self assert: (result at: #two) = 2