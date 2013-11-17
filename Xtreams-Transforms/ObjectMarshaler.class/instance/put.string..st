"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing string: string
	<writes: 'Core.String'>
	<writes: 'Core.ByteString'>
	<writes: 'Core.TwoByteString'>
	<writes: 'Core.FourByteString'>
	<writes: 'Core.ByteSymbol'>
	<writes: 'Core.TwoByteSymbol'>
	<writes: 'Core.FourByteSymbol'>


	self put: writing integer: string size.
	string do: [:character | self put: writing character: character]
