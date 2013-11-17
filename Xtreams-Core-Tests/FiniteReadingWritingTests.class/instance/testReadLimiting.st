"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - substream slicing
"
testReadLimiting
	| subinput limiter |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	limiter := (self input limiting: 3) slicing.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 1 1 1 ].
	self should: [subinput get] raise: Incomplete.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 2 2 2 ].
	self should: [subinput get] raise: Incomplete.

	self should: [limiter get get] raise: Incomplete.
	self should: [limiter get] raise: Incomplete
