"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading bytes: aClass
	<reads: 'Core.ByteArray'>

	| size bytearray |
	size := self get: reading integer: nil.
	bytearray := ByteArray new: size.
	1 to: size do: [:each | bytearray at: each put: (self get: reading byte: nil)].
	^bytearray
