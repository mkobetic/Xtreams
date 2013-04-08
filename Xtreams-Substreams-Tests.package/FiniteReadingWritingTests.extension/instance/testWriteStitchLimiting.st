"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream stitching
"
testWriteStitchLimiting
	| limiting |
	limiting := [self output limiting: 3] reading stitching.

	limiting write: #[ 1 1 1 2 2 2 3 3 3 ].
	limiting close.

	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]