"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading interval: aClass
	<analyse: 'Core.Interval'>

	reading log: ['interval: ', aClass fullName] do: [
		self analyse: reading.
		self analyse: reading.
		self analyse: reading]
