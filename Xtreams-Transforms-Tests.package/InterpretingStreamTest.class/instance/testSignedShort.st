"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSignedShort
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedShort.
	interpreting put: -31000.
	interpreting put: 31000.
	interpreting := stream contents reading interpreting: #signedShort.
	self assert: interpreting get = -31000.
	self assert: interpreting get = 31000