"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testOneArgumentReading
	self assert:
		([:out | 1 to: 10 do: [:i | out put: i]] reading
			contentsSpecies: ByteArray;
			read: 5) = #[ 1 2 3 4 5 ]
