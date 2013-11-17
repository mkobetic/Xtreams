"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testWriteLimiting
	| limiting suboutput |
	limiting := (self output limiting: 3) slicing.

	suboutput := limiting get.
	suboutput write: #[ 1 1 1 ].
	self should: [suboutput put: 1] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 2 2 2 ].
	self should: [suboutput put: 2] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 3 3 3 ].
	self should: [suboutput put: 3] raise: Incomplete.

	limiting close.
	self assert: (self input read: 9) = #[ 1 1 1 2 2 2 3 3 3 ]
