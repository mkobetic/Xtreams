"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingInsert: count into: aWriteStream.
	^count