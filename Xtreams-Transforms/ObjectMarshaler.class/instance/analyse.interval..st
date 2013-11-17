"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading interval: aClass
	<analyse: 'Core.Interval'>

	reading log: ['interval: ', aClass fullName] do: [
		self analyse: reading.
		self analyse: reading.
		self analyse: reading]
