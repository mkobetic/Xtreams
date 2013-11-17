"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testSeekForwardPastEnd

	self output write: #[ 1 2 3 4 ]; close.
	self input ++ 2.
	self assert: (
		[       self input ++ 4. false
		] on: Incomplete do: [ :eos |
			eos count = 2 ]).
	self should: [ self input get ] raise: Incomplete.
	self assert: (
		[       self input ++ 4. false
		] on: Incomplete do: [ :eos |
			eos count = 0 ]).
