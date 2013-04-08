"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testNumberReal

	self assert: (JSON decode: '42.42') - 42.42 < 0.001