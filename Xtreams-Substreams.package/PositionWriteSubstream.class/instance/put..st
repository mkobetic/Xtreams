"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	| object |
	object := destination put: anObject.
	position := position + 1.
	^object