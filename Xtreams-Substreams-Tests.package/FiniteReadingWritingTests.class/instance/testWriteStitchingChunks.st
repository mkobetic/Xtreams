"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream stitching
"
testWriteStitchingChunks
"Chunks are prefixed with size in the first byte. Below we have 3 chunks of size 1, 3 and 7, and terminating 0 chunk."

	| contents buffer |
	buffer := RingBuffer on: (ByteArray new: 3).
	[       (buffer writing limiting: buffer cacheSize)
			closeBlock: [ self output put: buffer readSize; write: buffer ];
			yourself
	] reading stitching
		write: (1 to: 7); flush;
		write: (8 to: 15); close.
	self output close.
	contents := self input rest.
	self assert: contents =
		#[      3 1 2 3 "first chunk"
			3 4 5 6 "second chunk"
			1 7             "short chunk after flush"
			3 8 9 10 "full chunk"
			3 11 12 13 "full chunk"
			2 14 15 "final short chunk" ]
