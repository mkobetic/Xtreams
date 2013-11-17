"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing dictionary: dictionary
	<writes: 'Core.Dictionary'>
	<writes: 'Core.KeyedCollection'>

	self put: writing integer: dictionary size.
	dictionary keysAndValuesDo: [:key :value |
		self marshal: writing object: key.
		self marshal: writing object: value]
