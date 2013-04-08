"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testFloat
	marshaling put: 5.4.
	marshaling put: -172.111.
	marshaling put: -172.11102d.
	self analyse.
	self assert: marshaling get = 5.4.
	self assert: marshaling get = -172.111.
	self assert: marshaling get = -172.11102d