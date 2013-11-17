"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing set: set
	<writes: 'Core.Set'>

	self put: writing integer: set size.
	set do: [:object | self marshal: writing object: object]
