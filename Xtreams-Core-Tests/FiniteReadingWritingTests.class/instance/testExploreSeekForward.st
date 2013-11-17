"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testExploreSeekForward
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self assert: (in explore: [in ++ 2. in rest = #[3 4]]).
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
