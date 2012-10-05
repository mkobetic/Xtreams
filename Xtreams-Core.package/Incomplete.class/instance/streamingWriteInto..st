private
streamingWriteInto: aWriteStream
	collection ifNil: [^0].
	aWriteStream write: count from: collection at: start.
	^count