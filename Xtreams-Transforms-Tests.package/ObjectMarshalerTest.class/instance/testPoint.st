"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testPoint
	marshaling put: -1 @ 2.
	marshaling put: 3.4 @ -4.5.
	marshaling put: 5 @ 5.
	self analyse.
	self assert: marshaling get = (-1 @ 2).
	self assert: marshaling get = (3.4 @ -4.5).
	self assert: marshaling get = (5 @ 5)
