"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - core
"
analyse: reading character: aClass
	<analyse: 'Core.Character'>

	| character |
	reading log: ['character: ', character printString] do: [character := self get: reading character: aClass]
