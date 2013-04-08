"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testString
	marshaling put: 'testing Ω'.
	self analyse.
	self assert: marshaling get = 'testing Ω'