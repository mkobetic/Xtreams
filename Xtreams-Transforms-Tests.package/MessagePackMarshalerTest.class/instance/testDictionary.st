"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDictionary
	| fixed small big |
	big := Dictionary new: 65537.
	1 to: 65537 do: [:i | big at: i put: 1].
	small := Dictionary new: 255.
	1 to: 255 do: [:i | small at: i put: i].
	fixed := Dictionary new
		at: 1 put: big;
		at: 2 put: small;
		yourself.
	marshaling put: fixed.
	marshaling put: small.
	marshaling put: big.
	self analyse.
	self assert: marshaling get = fixed.
	self assert: marshaling get = small.
	self assert: marshaling get = big
