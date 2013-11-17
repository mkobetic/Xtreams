"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - core
"
get: reading character: aClass
	<reads: 'Core.Character'>

	^Character codePoint: (self get: reading integer: nil)
