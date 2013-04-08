"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading collection: aClass
	<analyse: 'Core.Collection'>
	<analyse: 'Core.OrderedCollection'>
	<analyse: 'Core.Array'>
	<analyse: 'Core.Set'>

	| size |
	reading log: ['collection: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat: [self analyse: reading]]