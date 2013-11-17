"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
put: anObject
	| free |
	free := destination size - position.
	free < 1 ifTrue: [destination := destination copyGrownToAtLeast: destination size + 1].
	position := position + 1.
	destination at: position put: anObject.
	length := length + 1.
	^anObject
