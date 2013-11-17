"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testExploreSeekBackwardPastBeginning
	| in |
	self output write: #[ 1 2 3 4 ]; close.
	in := self input positioning.
	self should: [ in explore: [in read: 2; -- 4 ] ] raise: Incomplete.
	self should: [ in explore: [in read: 2; -= 6 ] ] raise: Incomplete.
	self assert: in rest = #[1 2 3 4].
	self should: [in get] raise: Incomplete
