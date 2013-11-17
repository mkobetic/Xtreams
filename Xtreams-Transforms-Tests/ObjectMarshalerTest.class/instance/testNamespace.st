"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testNamespace
	marshaling put: Root.Smalltalk.
	marshaling put: Root.Smalltalk.Xtreams.
	self analyse.
	self assert: marshaling get = Root.Smalltalk.
	self assert: marshaling get = Root.Smalltalk.Xtreams
