private
streamingInsertInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingInsert: count into: aWriteStream.
	^count