"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing set: set
	<writes: 'Core.Set'>

	self put: writing integer: set size.
	set do: [:object | self marshal: writing object: object]
