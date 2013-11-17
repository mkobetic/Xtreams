"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testInsertInTheMiddle

	| chunk |
	chunk := 'hello'.
	buffer := RingBuffer on: (String new: chunk size * 5).
	buffer write: chunk; write: chunk.
	buffer writePosition: chunk size.
	buffer insert: chunk.
	self assert: buffer writePosition = (chunk size * 2).
	self assert: buffer activeSize = (chunk size * 3)
