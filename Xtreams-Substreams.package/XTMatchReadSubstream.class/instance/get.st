accessing
get
	buffer hasDataToRead ifTrue: [^buffer get].
	substreamAtEnd ifTrue: [Incomplete zero raise].

	self gobble.
	buffer hasDataToRead ifFalse: [Incomplete zero raise].
	^buffer get