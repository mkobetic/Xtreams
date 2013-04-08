"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseString

	| string c |
	string := String new writing.
	self next = $" ifFalse: [self error: 'Failed parsing String'].
	[	(c := self next) = $"
	] whileFalse: [
		c = $\ ifTrue: [ c := self parseSpecialCharacter ].
		string put: c ].
	^string close; terminal