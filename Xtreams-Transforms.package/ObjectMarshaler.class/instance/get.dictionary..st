"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading dictionary: aClass
	<reads: 'Core.Dictionary'>
	<reads: 'Core.KeyedCollection'>

	| size dictionary |
	size := self get: reading integer: nil.
	dictionary := aClass new.
	size timesRepeat: [dictionary at: (self unmarshal: reading) put: (self unmarshal: reading)].
	^dictionary