"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testNumberNegative

	self assert: (JSON decode: '-1') = -1