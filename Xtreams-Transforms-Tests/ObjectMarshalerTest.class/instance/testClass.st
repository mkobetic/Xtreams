"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testClass
	marshaling put: UndefinedObject.
	marshaling put: ObjectMarshalerTest.
	self analyse.
	self assert: marshaling get = UndefinedObject.
	self assert: marshaling get = ObjectMarshalerTest
