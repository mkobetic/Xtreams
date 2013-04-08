"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseArray

	| array |
	self next = $[ ifFalse: [self error: 'Failed parsing array'].
	array := Array new writing.
	self skipWhitespace.
	[	self peekNext = $]
	] whileFalse: [
		array put: self get.
		(self skipWhitespace; peekNext) = $, ifTrue: [
			self next; skipWhitespace ] ].
	self next.
	^array close; terminal