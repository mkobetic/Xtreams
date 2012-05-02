*Xtreams-Core-private
streamingInsertInto: aWriteStream
	aWriteStream insert: self size from: self at: 1.
	^self size