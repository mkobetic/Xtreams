"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingInsert: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingInsertInto: aWriteStream]
