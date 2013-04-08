"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - seeking
"
testExploreSeekForwardPastEnd
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self should: [ in explore: [in ++ 8] ] raise: Incomplete.
	self should: [ in explore: [in += 8] ] raise: Incomplete.
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete