"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - core
"
analyse: reading character: aClass
	<analyse: 'Core.Character'>

	| character |
	reading log: ['character: ', character printString] do: [character := self get: reading character: aClass]
