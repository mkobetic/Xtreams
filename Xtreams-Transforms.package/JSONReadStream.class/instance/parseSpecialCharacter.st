"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private-parsing
"
parseSpecialCharacter

	| c |
	c := self next.
	c = $\ ifTrue: [^$\].
	c = $" ifTrue: [^$"].
	c = $/ ifTrue: [^$/].
	c = $b ifTrue: [^Character backspace].
	c = $f ifTrue: [^Character newPage].
	c = $n ifTrue: [^Character lf].
	c = $r ifTrue: [^Character cr].
	c = $t ifTrue: [^Character tab].
	c = $u ifTrue: [^self parseUnicodeCodePoint: (self next: 4) asLowercase].
	self error: 'Failed parsing special character'