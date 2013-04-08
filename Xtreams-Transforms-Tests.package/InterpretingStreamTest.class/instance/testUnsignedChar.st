"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUnsignedChar
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #char.
	0 to: 255 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #char) rest asArray = (0 to: 255)