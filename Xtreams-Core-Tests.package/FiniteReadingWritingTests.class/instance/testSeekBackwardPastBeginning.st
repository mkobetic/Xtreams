"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - seeking
"
testSeekBackwardPastBeginning

	self output write: #[ 1 2 3 4 ]; close.
	[[self input -- 1]
		on: Incomplete do: [:incomplete | ^self assert: incomplete count = 0]]
		on: Error do: [:error | ^self deny: self input isPositionable].

	"If neither exception was raised, that is a problem."
	self deny: true