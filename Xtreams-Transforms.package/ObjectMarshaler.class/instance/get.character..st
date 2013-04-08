"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - core
"
get: reading character: aClass
	<reads: 'Core.Character'>

	^Character codePoint: (self get: reading integer: nil)