"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testOneArgumentReading

	| stream |
	stream := [:out | 1 to: 10 do: [:i | out put: i]] reading contentsSpecies: ByteArray; yourself.
	self assert: (stream read: 5) = #[ 1 2 3 4 5 ].
	stream close