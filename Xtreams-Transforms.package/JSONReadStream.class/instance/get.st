"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get

	| negated |
	self skipWhitespace.
	next := self next.
	next = ${ ifTrue: [^self parseObject].
	next = $[ ifTrue: [^self parseArray].
	next = $" ifTrue: [^self parseString].
	next = $n ifTrue: [^self parseNull].
	next = $t ifTrue: [^self parseTrue].
	next = $f ifTrue: [^self parseFalse].
	negated := false.
	next = $- ifTrue: [ next := source get. negated := true].
	next isDigit ifTrue: [ | number |
		number := self parseNumber.
		^negated ifTrue: [number negated] ifFalse: [number]].
	self error: 'Invalid JSON'