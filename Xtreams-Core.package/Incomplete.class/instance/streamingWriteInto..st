"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream write: count from: collection at: start.
	^count