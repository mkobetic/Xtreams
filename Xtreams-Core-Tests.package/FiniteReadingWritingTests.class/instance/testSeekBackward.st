"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - seeking
"
testSeekBackward

	self output write: #[ 1 2 3 4 ]; close.
	self input read: 2.
	[self input -- 2] on: Error do: [:error |
		self deny: self input isPositionable].
	self input isPositionable
		ifTrue:	[self assert: self input rest = #[1 2 3 4]]
		ifFalse:	[self assert: self input rest = #[3 4]].