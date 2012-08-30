*Xtreams-Core-private
streamingWriteInto: aWriteStream
	aWriteStream write: self size from: self at: 1.
	^self size