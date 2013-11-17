"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testNamespace
	marshaling put: Root.Smalltalk.
	marshaling put: Root.Smalltalk.Xtreams.
	self analyse.
	self assert: marshaling get = Root.Smalltalk.
	self assert: marshaling get = Root.Smalltalk.Xtreams
