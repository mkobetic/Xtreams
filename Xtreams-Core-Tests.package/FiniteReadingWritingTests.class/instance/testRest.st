"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testRest

	self output write: #[ 1 2 3 4 ]; close.
	self assert: self input rest = #[1 2 3 4].
	self assert: self input rest = #[]
