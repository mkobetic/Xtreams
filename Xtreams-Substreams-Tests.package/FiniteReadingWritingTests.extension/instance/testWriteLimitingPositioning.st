"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteLimitingPositioning
	| limiting suboutput |

	"If we're not on a positioning stream, there's no point testing substream positioning"
	self output isPositionable ifFalse: [^self].

	limiting := (self output limiting: 3) slicing.

	suboutput := limiting get.
	suboutput write: #[ 1 4 4 ].
	self assert: suboutput position = 3.
	self assert: suboutput length = 3.
	self assert: suboutput available = 0.
	suboutput -- 2.
	self assert: suboutput position = 1.
	self assert: suboutput length = 3.
	self assert: suboutput available = 2.
	suboutput write: #[ 1 1 ].
	self should: [suboutput put: 1] raise: Incomplete.

	suboutput := limiting get.
	suboutput write: #[ 2 2 3 ].
	suboutput += 1.
	self assert: suboutput position = 1.
	self assert: suboutput length = 3.
	self assert: suboutput available = 2.
	suboutput ++ 1.
	self assert: suboutput position = 2.
	self assert: suboutput length = 3.
	self assert: suboutput available = 1.
	suboutput put: 2.
	self should: [suboutput put: 2] raise: Incomplete.

	limiting close.
	self assert: (self input read: 6) = #[ 1 1 1 2 2 2 ]