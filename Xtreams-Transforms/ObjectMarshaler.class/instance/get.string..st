"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
