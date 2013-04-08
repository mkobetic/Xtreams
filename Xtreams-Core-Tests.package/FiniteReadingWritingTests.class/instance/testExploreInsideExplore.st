"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - seeking
"
testExploreInsideExplore
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [(in explore: [in rest = #[1 2 3 4]]) & (in rest = #[1 2 3 4])]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete