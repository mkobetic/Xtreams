"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDuplicateReading
	| copy |
	copy := Array new writing.
	self assert: ((0 to: 255) reading duplicating: copy) rest = copy conclusion