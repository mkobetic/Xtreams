"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - interpreting
"
testInterpretingPoints

	| points result |
	points := (Random new reading transforming: [ :in :out | out put: in get @ in get ]) read: 5.
	(self output interpreting: [ :b :i :o | b doubleAt: i put: o x. b doubleAt: i + 8 put: o y ] size: 16 )
		write: points;
		close.
	result := (self input interpreting: [ :b :i | (b doubleAt: i) @ (b doubleAt: i + 8) ] size: 16 cacheSize: 5) read: points size.
	self assert: points = result