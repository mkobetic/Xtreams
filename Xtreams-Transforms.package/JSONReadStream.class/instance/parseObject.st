"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseObject

	| object |
	self next = ${ ifFalse: [ self error: 'Failed parsing object' ].
	object := Dictionary new.
	self skipWhitespace.
	[	self peekNext = $}
	] whileFalse: [ | key value |
		key := self parseString.
		(self skipWhitespace; next) = $: ifFalse: [ self error: 'Failed parsing object' ].
		value := self skipWhitespace; get.
		object at: key asSymbol put: value.
		(self skipWhitespace; peekNext) = $, ifTrue: [
			self next; skipWhitespace] ].
	self next.
	^object