"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testLargeInteger
	marshaling put: SmallInteger maxVal * 2.
	marshaling put: SmallInteger minVal * 2.
	marshaling put: 2 ** 256.
	marshaling put: -2 ** 256.
	self analyse.
	self assert: marshaling get = (SmallInteger maxVal * 2).
	self assert: marshaling get = (SmallInteger minVal * 2).
	self assert: marshaling get = (2 ** 256).
	self assert: marshaling get = (-2 ** 256)