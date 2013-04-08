"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseInteger: aBlock
	
	| number char digits |
	number := 0.
	digits := 0.
	[	[ (char := self next) isDigit ] whileTrue: [
			digits := digits + 1.
			number := number * 10 + (char asInteger - 48 "$0 asInteger") ].
		next := char.
	] on: Incomplete do: [ :ex | digits > 0 ifFalse: [ ex pass ] ].
	^aBlock value: number value: digits