"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #signedChar.
	-120 to: 120 do: [:each | interpreting put: each].
	interpreting := stream contents reading interpreting: #signedChar.
	self assert: interpreting rest = (-120 to: 120)