"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testRaw
	| big |
	big := ByteArray new: 100000 withAll: 1.
	marshaling put: #[10 255 0].
	marshaling put: (ByteArray withAll: (1 to: 255)).
	marshaling put: big.
	self analyse.
	self assert: marshaling get = #[10 255 0].
	self assert: marshaling get = (ByteArray withAll: (1 to: 255)).
	self assert: marshaling get = big