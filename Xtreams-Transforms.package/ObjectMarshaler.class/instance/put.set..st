"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing set: set
	<writes: 'Core.Set'>

	self put: writing integer: set size.
	set do: [:object | self marshal: writing object: object]