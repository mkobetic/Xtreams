"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	| object |
	object := destination put: anObject.
	position := position + 1.
	^object
