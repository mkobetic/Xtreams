"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - numbers
"
analyse: reading integerMedium: aClass
	| integer |
	reading log: ['medium integer: ', integer printString] do: [integer := self get: reading integerMedium: aClass]
