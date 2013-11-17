"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: tests
"
testOneArgumentReading
	self assert:
		([:out | 1 to: 10 do: [:i | out put: i]] reading
			contentsSpecies: ByteArray;
			read: 5) = #[ 1 2 3 4 5 ]
