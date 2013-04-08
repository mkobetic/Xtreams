"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utility
"
decode: aString

	| stream |
	stream := aString reading marshaling: self.
	^[ stream get ] ensure: [ stream close ]