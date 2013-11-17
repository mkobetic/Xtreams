"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testFloat
	marshaling put: 5.4.
	marshaling put: -172.11102.
	self analyse.
	self assert: marshaling get = 5.4.
	self assert: marshaling get = -172.11102
