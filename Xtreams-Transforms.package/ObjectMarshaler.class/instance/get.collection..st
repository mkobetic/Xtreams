"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading collection: aClass
	<reads: 'Core.Collection'>
	<reads: 'Core.OrderedCollection'>
	<reads: 'Core.Array'>

	| collection size |
	size := self get: reading integer: nil.
	collection := aClass withSize: size.
	1 to: size do: [:index | collection at: index put: (self unmarshal: reading)].
	^collection