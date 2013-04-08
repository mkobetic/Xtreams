"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - numbers
"
analyse: reading double: aClass
	<analyse: 'Core.Double'>
	<analyse: 'Core.SmallDouble'>

	| double |
	reading log: ['double: ', double printString] do: [double := self get: reading double: aClass]