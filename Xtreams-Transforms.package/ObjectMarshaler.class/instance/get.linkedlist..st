"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading linkedlist: aClass
	<reads: 'Core.LinkedList'>

	| collection size |
	size := self get: reading integer: nil.
	collection := aClass new.
	1 to: size do: [:index | collection add: (self unmarshal: reading)].
	^collection
