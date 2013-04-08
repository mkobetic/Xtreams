"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteMatching: aStream inclusive: tail
	^TestWriteSubstream on: aStream test: self inclusive: tail