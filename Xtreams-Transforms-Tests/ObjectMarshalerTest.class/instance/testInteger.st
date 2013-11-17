"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testInteger
	marshaling put: 0.
	marshaling put: 1.
	marshaling put: 255.
	marshaling put: 254.
	marshaling put: -1.
	marshaling put: SmallInteger maxVal.
	marshaling put: SmallInteger minVal.
	self analyse.
	self assert: marshaling get = 0.
	self assert: marshaling get = 1.
	self assert: marshaling get = 255.
	self assert: marshaling get = 254.
	self assert: marshaling get = -1.
	self assert: marshaling get = SmallInteger maxVal.
	self assert: marshaling get = SmallInteger minVal.
