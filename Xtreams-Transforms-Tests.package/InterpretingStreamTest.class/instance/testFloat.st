"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testFloat
	| interpreting |
	stream := ByteArray new writing.
	interpreting := stream interpreting: #float.
	-50.0 to: 50.0 by: 0.5 do: [:each | interpreting put: each].
	self assert: (stream contents reading interpreting: #float) rest = (-50 to: 50 by: 0.5)