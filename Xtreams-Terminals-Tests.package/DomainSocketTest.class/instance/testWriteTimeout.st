"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: testing
"
testWriteTimeout

	| happened succeeded constant |
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