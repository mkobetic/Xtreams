"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - substream slicing
"
testWriteClosing
	| closing suboutput |
	closing := (self output closing: [ :s | s put: 0 ]) slicing.

	suboutput := closing get.
	suboutput write: #[ 1 1 1 ]; close.

	suboutput := closing get.
	suboutput write: #[ 2 2 2 ]; close.
	closing close.

	self assert: (self input read: 8) = #[ 1 1 1 0 2 2 2 0 ]
