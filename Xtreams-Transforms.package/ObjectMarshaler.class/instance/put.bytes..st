"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing bytes: bytearray
	<writes: 'Core.ByteArray'>

	self put: writing integer: bytearray size.
	bytearray do: [:byte | self put: writing byte: byte]