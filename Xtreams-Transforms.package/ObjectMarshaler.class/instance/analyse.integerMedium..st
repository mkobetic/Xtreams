"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - numbers
"
analyse: reading integerMedium: aClass
	| integer |
	reading log: ['medium integer: ', integer printString] do: [integer := self get: reading integerMedium: aClass]