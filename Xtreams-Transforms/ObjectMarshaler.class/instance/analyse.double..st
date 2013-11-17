"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - numbers
"
analyse: reading double: aClass
	<analyse: 'Core.Double'>

	| double |
	reading log: ['double: ', double printString] do: [double := self get: reading double: aClass]
