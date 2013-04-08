"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testPut
	
	self output put: 1.
	self assert: self input get = 1