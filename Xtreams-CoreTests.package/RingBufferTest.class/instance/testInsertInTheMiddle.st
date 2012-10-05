tests
testInsertInTheMiddle

	| chunk |
	chunk := 'hello'.
	buffer := XTRingBuffer on: (String new: chunk size * 5).
	buffer write: chunk; write: chunk.
	buffer writePosition: chunk size.
	buffer insert: chunk.
	self assert: buffer writePosition = (chunk size * 2).
	self assert: buffer activeSize = (chunk size * 3)