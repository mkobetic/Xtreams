"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading interval: aClass
	<analyse: 'Core.Interval'>

	reading log: ['interval: ', aClass fullName] do: [
		self analyse: reading.
		self analyse: reading.
		self analyse: reading]