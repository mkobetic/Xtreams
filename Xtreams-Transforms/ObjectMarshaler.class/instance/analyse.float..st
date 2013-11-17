"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - numbers
"
analyse: reading float: aClass
	<analyse: 'Core.Float'>

	| float |
	reading log: ['float: ', float printString] do: [float := self get: reading float: aClass]
