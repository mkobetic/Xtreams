"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
