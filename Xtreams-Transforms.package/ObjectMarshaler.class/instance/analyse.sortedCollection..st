"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading sortedCollection: aClass
	<analyse: 'Core.SortedCollection'>

	| size |
	size := 0.
	reading log: ['sorted collection: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		reading log: ['sort block'] do: [self analyse: reading].
		size timesRepeat: [self analyse: reading]]