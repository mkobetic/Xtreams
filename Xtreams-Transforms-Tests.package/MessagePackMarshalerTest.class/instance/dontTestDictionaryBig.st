"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
dontTestDictionaryBig
	"A dictionary with keys > 16k starts to hit the hash limit and causes lots of reshuffling as the dictionary is build, during the start of the test and during the unmarshal of the test. Because of this, we have opted to exclude testing the big variant from the test suite."
"
	(self selector: #dontTestDictionaryBig) run
"

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