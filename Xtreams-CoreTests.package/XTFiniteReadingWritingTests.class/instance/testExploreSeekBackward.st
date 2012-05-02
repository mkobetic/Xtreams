tests - seeking
testExploreSeekBackward
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [in read: 3; -- 1. in rest = #[3 4]]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete