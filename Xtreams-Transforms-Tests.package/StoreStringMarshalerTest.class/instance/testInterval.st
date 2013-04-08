"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testInterval
	marshaling put: (1 to: 12 by: 2).
	self analyse.
	self assert: marshaling get = (1 to: 11 by: 2)