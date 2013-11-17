"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: tests
"
testBuffered
	| writing |
	writing := ByteArray new writing buffering: 10.
	writing write: #[ 1 2 3 4 5 ].
	self deny: (writing terminal first: 5) = #[ 1 2 3 4 5 ].
	writing write: #[ 6 7 8 9 ].
	self deny: (writing terminal first: 9) = #[ 1 2 3 4 5 6 7 8 9 ].
	writing put: 0.
	self deny: (writing terminal first: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ].
	writing write: #[ 11 12 ].
	self assert: (writing terminal first: 10) = #[ 1 2 3 4 5 6 7 8 9 0 ].
	self deny: (writing terminal first: 12) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 ].
	writing flush.
	self assert: (writing terminal first: 12) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 ].
	writing write: #[ 13 14 ].
	self deny: (writing terminal first: 14) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 13 14 ].
	writing close.
	self assert: (writing terminal first: 14) = #[ 1 2 3 4 5 6 7 8 9 0 11 12 13 14 ].
