"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: analyse - complex
"
analyse: reading dictionary: aClass
	<analyse: 'Core.Dictionary'>
	<analyse: 'Core.KeyedCollection'>

	| size |
	reading log: ['dictionary: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat:
			[self analyse: reading.
			self analyse: reading]]
