"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSingletons
	marshaling put: nil.
	marshaling put: true.
	marshaling put: false.
	self analyse.
	self assert: marshaling get = nil.
	self assert: marshaling get = true.
	self assert: marshaling get = false
