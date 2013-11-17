"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
put: anObject
	| object |
	object := destination put: anObject.
	position := position + 1.
	^object
