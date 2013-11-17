"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading linkedlist: aClass
	<analyse: 'Core.LinkedList'>

	| size |
	reading log: ['linkedlist: ', aClass fullName, ' size: ', size printString] do: [
		size := self get: reading integer: nil.
		size timesRepeat: [self analyse: reading]]
