"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing collection: collection
	<writes: 'Core.Collection'>
	<writes: 'Core.OrderedCollection'>
	<writes: 'Core.Array'>

	self put: writing integer: collection size.
	collection do: [:object | self marshal: writing object: object]
