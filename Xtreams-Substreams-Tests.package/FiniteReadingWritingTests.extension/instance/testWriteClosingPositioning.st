"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteClosingPositioning
	| closing suboutput |

	"If we're on a non-positionable stream, there's no point trying to test substream positioning"
	self output isPositionable ifFalse: [^self].

	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 3 3 ].
	self assert: suboutput position = 3.
	suboutput -- 2.
	self assert: suboutput position = 1.
	suboutput write: #[ 1 1 ].

	suboutput := closing get.
	suboutput write: #[ 2 2 3 ].
	suboutput += 1.
	self assert: suboutput position = 1.
	suboutput ++ 1.
	suboutput put: 2.

	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]