"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDictionary
	| fixed small |
	small := Dictionary new: 255.
	1 to: 255 do: [:i | small at: i put: i].
	fixed := Dictionary new
		at: 1 put: small;
		yourself.
	marshaling put: fixed.
	marshaling put: small.
	self analyse.
	self assert: marshaling get = fixed.
	self assert: marshaling get = small