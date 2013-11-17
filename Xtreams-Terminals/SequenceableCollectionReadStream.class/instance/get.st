"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	position = source size ifTrue: [Incomplete zero raise].
	position := position + 1.
	^source at: position
