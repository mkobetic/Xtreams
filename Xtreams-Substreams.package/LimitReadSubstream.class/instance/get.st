accessing
get
	position = limit ifTrue: [Incomplete zero raise].
	^super get