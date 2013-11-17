"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading sortedCollection: aClass
	<reads: 'Core.SortedCollection'>

	| collection size sortBlock |
	size := self get: reading integer: nil.
	sortBlock := self unmarshal: reading.
	collection := Array new: size.
	1 to: size do: [:index | collection at: index put: (self unmarshal: reading)].
	^SortedCollection withAll: collection sortBlock: sortBlock
