"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWritingFrom

	| freq |
	freq := Bag new.
	nil writing write: 500 from: (
		(Random new reading collecting: [ :e | (e * 4) floor ])
			doing: [ :e | freq add: e ]).
	self assert: freq size = 500.
	self assert: freq asSet size = 4.