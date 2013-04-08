"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testWriteCustomObject

	| result inverse |
	result := JSON encode: self.
	inverse := JSON decode: result.
	self assert: (inverse at: #example1) = 'Produced from JSONMarshalingTest'.
	self assert: ((inverse at: #example2) isKindOf: Dictionary)