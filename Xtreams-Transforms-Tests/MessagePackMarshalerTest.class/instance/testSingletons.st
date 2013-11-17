"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
