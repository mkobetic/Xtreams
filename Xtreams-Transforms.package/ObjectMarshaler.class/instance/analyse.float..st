"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - numbers
"
analyse: reading float: aClass
	<analyse: 'Core.Float'>

	| float |
	reading log: ['float: ', float printString] do: [float := self get: reading float: aClass]
