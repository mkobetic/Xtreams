private
streamingWriteInto: aWriteStream

	| count |
	count := dataLength - readPosition.
	self streamingWrite: count into: aWriteStream.
	^count