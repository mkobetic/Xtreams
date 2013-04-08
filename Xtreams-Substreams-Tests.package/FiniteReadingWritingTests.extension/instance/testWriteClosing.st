"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteClosing
	| closing suboutput |
	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 1 1 ].

	suboutput := closing get.
	suboutput write: #[ 2 2 2 ].

	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]