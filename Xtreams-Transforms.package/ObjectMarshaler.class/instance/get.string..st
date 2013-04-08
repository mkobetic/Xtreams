"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading string: aClass
	<reads: 'Core.String'>
	<reads: 'Core.ByteString'>
	<reads: 'Core.TwoByteString'>
	<reads: 'Core.FourByteString'>

	| size string |
	size := self get: reading integer: nil.
	string := aClass new: size.
	1 to: size do: [:each | string at: each put: (self get: reading character: nil)].
	^string