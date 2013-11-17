"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
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
