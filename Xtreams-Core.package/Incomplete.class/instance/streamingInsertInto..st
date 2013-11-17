"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream insert: count from: collection at: start.
	^count
