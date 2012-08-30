private
streamingInsertInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream insert: count from: collection at: start.
	^count