private
streamingInsertInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingInsert: count into: aWriteStream.
	^count