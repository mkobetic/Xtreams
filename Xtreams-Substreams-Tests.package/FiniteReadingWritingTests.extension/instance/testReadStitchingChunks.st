"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream stitching
"
testReadStitchingChunks
"Chunks are prefixed with size in the first byte. Below we have 3 chunks of size 1, 3 and 7, and terminating 0 chunk."

	| chunks contents stitched |
	chunks := (ByteArray withAll: (1 to: 14)), #[0].
	self output write: chunks; close.
	stitched := [ self input limiting: self input get ] reading stitching.
	contents := stitched rest.
	self assert: contents = #[2 4 5 6 8 9 10 11 12 13 14]