"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testString
	marshaling put: 'testing Î©'.
	self analyse.
	self assert: marshaling get = 'testing Î©'
