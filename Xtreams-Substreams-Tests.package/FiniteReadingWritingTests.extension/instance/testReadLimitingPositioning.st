"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testReadLimitingPositioning
	| subinput limiter |
	self output write: #[ 1 1 1 2 2 2 ]; close.
	limiter := (self input limiting: 3) slicing.

	subinput := limiter get.
	subinput ++ 2.
	self assert: subinput rest = #[ 1 ].
	subinput isPositionable
		ifTrue: [ subinput -- 2.
			self assert: subinput rest = #[ 1 1 ].
			subinput += 1.
			self assert: subinput rest = #[ 1 1 ].
			subinput -= 2.
			self assert: subinput rest = #[ 1 1 ] ]
		ifFalse: [ self should: [ subinput -- 2 ] raise: Error ].
	self should: [subinput get] raise: Incomplete.

	subinput := limiter get.
	self assert: (subinput read: 3) = #[ 2 2 2 ].
	self should: [subinput get] raise: Incomplete.

	self should: [limiter get get] raise: Incomplete.
	self should: [limiter get] raise: Incomplete