"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
put: anObject
	position = limit ifTrue: [Incomplete zero raise].
	^super put: anObject