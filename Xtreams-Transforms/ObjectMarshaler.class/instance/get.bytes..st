"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading bytes: aClass
	<reads: 'Core.ByteArray'>

	| size bytearray |
	size := self get: reading integer: nil.
	bytearray := ByteArray new: size.
	1 to: size do: [:each | bytearray at: each put: (self get: reading byte: nil)].
	^bytearray
