"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingInsert: count into: aWriteStream.
	^count