"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	| object |
	(length isNil or: [ position < length ]) ifFalse: [ Incomplete zero raise ].
	object := source at: position.
	position := position + 1.
	^object