accessing
put: anObject
	position = limit ifTrue: [Incomplete zero raise].
	^super put: anObject