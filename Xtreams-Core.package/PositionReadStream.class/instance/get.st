"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	| object |
	buffer hasDataToRead ifTrue: [^buffer get].
	object := source get.
	buffer put: object.
	buffer readSkip: 1.
	^object
