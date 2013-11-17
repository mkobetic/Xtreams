"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - numbers
"
analyse: reading double: aClass
	<analyse: 'Core.Double'>

	| double |
	reading log: ['double: ', double printString] do: [double := self get: reading double: aClass]
