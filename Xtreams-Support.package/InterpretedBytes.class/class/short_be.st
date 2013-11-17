"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: type descriptions
"
short_be

	self isBigEndian ifTrue: [ ^self short ].
	^Array with: 2 with: WordArray with: [:b :i | b unsignedShortAt: i bigEndian: true ] with: [:b :i :o | b unsignedShortAt: i put: o bigEndian: true ]
