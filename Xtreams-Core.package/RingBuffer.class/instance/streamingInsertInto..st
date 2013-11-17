"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingInsert: count into: aWriteStream.
	^count
