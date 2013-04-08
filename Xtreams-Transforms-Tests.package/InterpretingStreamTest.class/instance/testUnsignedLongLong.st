"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUnsignedLongLong
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #longlong.
	(SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100) do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #longlong) rest = ((SmallInteger maxVal - 100) to: (SmallInteger maxVal + 100))