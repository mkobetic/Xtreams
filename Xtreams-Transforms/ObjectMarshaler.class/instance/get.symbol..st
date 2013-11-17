"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading symbol: aClass
	<reads: 'Core.Symbol'>
	<reads: 'Core.ByteSymbol'>
	<reads: 'Core.TwoByteSymbol'>
	<reads: 'Core.FourByteSymbol'>

	^(self get: reading string: String) asSymbol
