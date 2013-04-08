"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing collection: collection
	<writes: 'Core.Collection'>
	<writes: 'Core.OrderedCollection'>
	<writes: 'Core.Array'>

	self put: writing integer: collection size.
	collection do: [:object | self marshal: writing object: object]