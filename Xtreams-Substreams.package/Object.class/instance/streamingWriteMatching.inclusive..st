"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingWriteMatching: aStream inclusive: tail
	^[:each | each == self] streamingWriteMatching: aStream inclusive: tail
