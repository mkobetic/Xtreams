"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testArray

	self assert: (JSON decode: '[ 1, 2, 3 ]') = #(1 2 3)