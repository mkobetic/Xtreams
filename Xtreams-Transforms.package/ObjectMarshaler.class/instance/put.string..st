"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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