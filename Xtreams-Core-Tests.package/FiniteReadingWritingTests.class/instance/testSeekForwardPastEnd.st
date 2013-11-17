"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
