"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
