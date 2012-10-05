accessing
put: anObject
	| object |
	object := destination put: anObject.
	position := position + 1.
	^object