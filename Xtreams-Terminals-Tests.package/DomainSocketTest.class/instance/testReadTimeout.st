"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: testing
"
testReadTimeout

	| happened |
	self should: [ (input reading: 100 milliseconds) get ] raise: Timeout.
	output writing put: 42; flush.
	self assert: (input reading: 100 milliseconds) get = 42.

	" test resumption "
	happened := false.
	[	self assert: (input reading: 100 milliseconds) get = 42
	] on: Timeout do: [ :ex |
		output writing put: 42; flush.
		happened := true.
		ex resume ].
	self assert: happened