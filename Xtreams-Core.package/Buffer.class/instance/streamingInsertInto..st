"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingInsert: count into: aWriteStream.
	^count
