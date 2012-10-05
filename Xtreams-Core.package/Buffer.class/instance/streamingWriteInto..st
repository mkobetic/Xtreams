private
streamingWriteInto: aWriteStream
	| count |
	count := writePosition - readPosition.
	count <= 0 ifTrue: [^0].
	self streamingWrite: count into: aWriteStream.
	^count