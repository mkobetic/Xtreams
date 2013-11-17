"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	buffer hasDataToRead ifTrue: [^buffer get].
	substreamAtEnd ifTrue: [Incomplete zero raise].

	self gobble.
	buffer hasDataToRead ifFalse: [Incomplete zero raise].
	^buffer get
