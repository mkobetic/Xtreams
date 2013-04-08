"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	substreamAtEnd ifTrue: [Incomplete zero raise].
	((substreamAtEnd := test value: anObject) and: [inclusive not]) ifTrue: [Incomplete zero raise].
	[destination put: anObject] on: Incomplete do: [:incomplete | destinationAtEnd := substreamAtEnd := true. incomplete pass].
	^anObject