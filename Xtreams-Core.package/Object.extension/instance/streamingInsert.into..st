*Xtreams-Core-private
streamingInsert: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingInsertInto: aWriteStream]