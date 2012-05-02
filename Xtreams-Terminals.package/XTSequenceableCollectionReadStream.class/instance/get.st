accessing
get
	position = source size ifTrue: [Incomplete zero raise].
	position := position + 1.
	^source at: position