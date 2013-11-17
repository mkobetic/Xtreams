"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing sortedCollection: collection
	<writes: 'Core.SortedCollection'>

	self put: writing integer: collection size.
	self marshal: writing object: collection sortBlock.
	collection do: [:object | self marshal: writing object: object]
