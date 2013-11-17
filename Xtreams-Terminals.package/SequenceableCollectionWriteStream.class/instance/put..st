"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
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
