"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream write: count from: collection at: start.
	^count
