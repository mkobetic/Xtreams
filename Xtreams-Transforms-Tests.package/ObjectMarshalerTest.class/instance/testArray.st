"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testArray
	marshaling put: (Array with: 1 with: -2.7 with: true).
	self analyse.
	self assert: marshaling get = (Array with: 1 with: -2.7 with: true)
