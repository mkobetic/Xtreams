"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testClass
	marshaling put: UndefinedObject.
	marshaling put: ObjectMarshalerTest.
	self analyse.
	self assert: marshaling get = UndefinedObject.
	self assert: marshaling get = ObjectMarshalerTest
