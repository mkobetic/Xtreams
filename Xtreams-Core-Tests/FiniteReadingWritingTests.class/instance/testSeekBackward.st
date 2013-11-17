"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests - seeking
"
testSeekBackward

	self output write: #[ 1 2 3 4 ]; close.
	self input read: 2.
	[self input -- 2] on: Error do: [:error |
		self deny: self input isPositionable].
	self input isPositionable
		ifTrue: [self assert: self input rest = #[1 2 3 4]]
		ifFalse:        [self assert: self input rest = #[3 4]].
