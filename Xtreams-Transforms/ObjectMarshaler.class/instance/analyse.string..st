"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading string: aClass
	<analyse: 'Core.String'>
	<analyse: 'Core.ByteString'>
	<analyse: 'Core.TwoByteString'>
	<analyse: 'Core.FourByteString'>

	| string |
	reading log: ['string: ', string printString] do: [string := self get: reading string: aClass]
