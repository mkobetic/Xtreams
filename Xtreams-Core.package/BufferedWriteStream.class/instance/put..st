"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject

	buffer cacheSize > buffer activeSize ifFalse: [self flush].
	buffer put: anObject.
	^1