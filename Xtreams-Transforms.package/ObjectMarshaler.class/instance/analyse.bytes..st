"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading bytes: aClass
	<analyse: 'Core.ByteArray'>

	| bytes |
	reading log: ['bytes: ', bytes printString] do: [bytes := self get: reading bytes: aClass]