"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	| free |
	free := length - position.
	free < 1 ifTrue: [self resizeTo: length + 1].
	destination at: position put: anObject.
	position := position + 1