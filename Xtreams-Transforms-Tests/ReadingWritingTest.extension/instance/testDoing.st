"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
