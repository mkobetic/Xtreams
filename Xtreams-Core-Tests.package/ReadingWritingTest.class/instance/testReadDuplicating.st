"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - transforming
"
testReadDuplicating

	| copy contents |
	contents := Array withAll: (0 to: 15).
	copy := Array new writing.
	self assert: (contents reading duplicating: copy) rest = contents.
	self assert: copy conclusion = contents
