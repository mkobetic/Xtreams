"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading symbol: aClass
	<reads: 'Core.Symbol'>
	<reads: 'Core.ByteSymbol'>
	<reads: 'Core.TwoByteSymbol'>
	<reads: 'Core.FourByteSymbol'>

	^(self get: reading string: String) asSymbol