"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing sortedCollection: collection
	<writes: 'Core.SortedCollection'>

	self put: writing integer: collection size.
	self marshal: writing object: collection sortBlock.
	collection do: [:object | self marshal: writing object: object]
