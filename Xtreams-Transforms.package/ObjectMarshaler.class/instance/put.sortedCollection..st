"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing sortedCollection: collection
	<writes: 'Core.SortedCollection'>

	self put: writing integer: collection size.
	self marshal: writing object: collection sortBlock.
	collection do: [:object | self marshal: writing object: object]