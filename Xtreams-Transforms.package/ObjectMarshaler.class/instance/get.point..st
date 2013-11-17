"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading point: aClass
	<reads: 'Core.Point'>

	^Point
		x: (self unmarshal: reading) 
		y: (self unmarshal: reading)
