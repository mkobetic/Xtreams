"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	position = source size ifTrue: [Incomplete zero raise].
	position := position + 1.
	^source at: position
