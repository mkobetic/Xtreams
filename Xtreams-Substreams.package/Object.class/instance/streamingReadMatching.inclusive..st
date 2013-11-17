"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingReadMatching: aStream inclusive: tail
	^[:each | each == self] streamingReadMatching: aStream inclusive: tail
