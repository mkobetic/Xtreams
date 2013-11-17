"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing collection: collection
	<writes: 'Core.Collection'>
	<writes: 'Core.OrderedCollection'>
	<writes: 'Core.Array'>

	self put: writing integer: collection size.
	collection do: [:object | self marshal: writing object: object]
