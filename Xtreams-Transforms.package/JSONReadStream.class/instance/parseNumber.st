"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseNumber
	
	| number negated exponent |
	number := self parseInteger: [ :int :digits | int ].
	next = $. ifFalse: [ ^number ].
	next := source get.
	number := (self parseInteger: [ :int :digits | (10.0d ** digits negated) * int ]) + number.
	('eE' includes: next) ifFalse: [ ^number ].
	negated := source get = $-.
	next := source get.
	exponent := self parseInteger: [ :int :digits | int ].
	negated ifTrue: [ exponent := exponent negated ].
	^number * (10.0d ** exponent)