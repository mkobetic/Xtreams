*Xtreams-Core-private
streamingWrite: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingWriteInto: aWriteStream].
	^anInteger