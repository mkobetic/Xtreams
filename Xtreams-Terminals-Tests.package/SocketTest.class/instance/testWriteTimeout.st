"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: testing
"
testWriteTimeout

	| happened succeeded constant |
	self assert: (OSHandle currentOS ~= #win32) description: 'Does not work on Windows (AR#65763)'.
	"AR#65763 Socket writeWaitWithTimeout: doesn't correctly signal when the outgoing buffer fills up on Windows"
	"Fill up the OS buffer"
	constant := 42 repeating contentsSpecies: ByteArray.
	self should: [ (output writing: 100 milliseconds) write: constant ] raise: Timeout.
	
	" test resumption "
	happened := succeeded := false.
	[	(output writing: 100 milliseconds) put: 42.
		succeeded := true
	] on: Timeout do: [ :ex |
		self assert: input reading get = 42.
		happened := true.
		ex resume ].
	self assert: happened.
	self assert: succeeded