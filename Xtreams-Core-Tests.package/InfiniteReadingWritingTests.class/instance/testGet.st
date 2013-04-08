"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testGet
	self output write: #[ 1 2 3 4 ].
	self assert: self input get = 1.
	self assert: self input get = 2.
	self assert: self input get = 3.
	self assert: self input get = 4