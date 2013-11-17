"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - numbers
"
analyse: reading integerSmall: aClass
	| integer |
	reading log: ['small integer: ', integer printString] do: [integer := self get: reading integerSmall: aClass]
