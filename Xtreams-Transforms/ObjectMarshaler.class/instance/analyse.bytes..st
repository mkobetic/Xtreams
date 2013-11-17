"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading bytes: aClass
	<analyse: 'Core.ByteArray'>

	| bytes |
	reading log: ['bytes: ', bytes printString] do: [bytes := self get: reading bytes: aClass]
