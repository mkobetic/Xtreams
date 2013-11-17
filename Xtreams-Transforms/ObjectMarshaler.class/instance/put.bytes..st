"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing bytes: bytearray
	<writes: 'Core.ByteArray'>

	self put: writing integer: bytearray size.
	bytearray do: [:byte | self put: writing byte: byte]
