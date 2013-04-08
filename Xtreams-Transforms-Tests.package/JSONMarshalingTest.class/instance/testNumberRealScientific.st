"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testNumberRealScientific

	self assert: (JSON decode: '4.242e-10') - 4.242d-10 < 0.1d-10