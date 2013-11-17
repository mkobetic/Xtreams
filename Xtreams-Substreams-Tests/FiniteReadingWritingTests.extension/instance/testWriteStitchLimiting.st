"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream stitching
"
testWriteStitchLimiting
	| limiting |
	limiting := [self output limiting: 3] reading stitching.

	limiting write: #[ 1 1 1 2 2 2 3 3 3 ].
	limiting close.

	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]
