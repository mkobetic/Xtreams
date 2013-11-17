"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testSeekBackwardPastBeginning

	self output write: #[ 1 2 3 4 ]; close.
	[[self input -- 1]
		on: Incomplete do: [:incomplete | ^self assert: incomplete count = 0]]
		on: Error do: [:error | ^self deny: self input isPositionable].

	"If neither exception was raised, that is a problem."
	self deny: true
