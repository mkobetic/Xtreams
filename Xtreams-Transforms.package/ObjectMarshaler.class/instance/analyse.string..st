"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading string: aClass
	<analyse: 'Core.String'>
	<analyse: 'Core.ByteString'>
	<analyse: 'Core.TwoByteString'>
	<analyse: 'Core.FourByteString'>

	| string |
	reading log: ['string: ', string printString] do: [string := self get: reading string: aClass]
