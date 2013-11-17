"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testDoing
	| outing inning |
	outing := ByteArray new writing.
	(self output doing: [:each | outing put: each]) write: #[ 1 2 3 4 5 ].
	self assert: outing contents = #[ 1 2 3 4 5 ].

	inning := ByteArray new writing.
	self assert: ((self input doing: [:each | inning put: each]) read: 5) = #[ 1 2 3 4 5 ].
	self assert: inning contents = #[ 1 2 3 4 5 ]
