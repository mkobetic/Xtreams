"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading symbol: aClass
	<analyse: 'Core.Symbol'>
	<analyse: 'Core.ByteSymbol'>
	<analyse: 'Core.TwoByteSymbol'>
	<analyse: 'Core.FourByteSymbol'>

	| symbol |
	reading log: ['symbol: ', symbol printString] do: [symbol := self get: reading symbol: aClass]
