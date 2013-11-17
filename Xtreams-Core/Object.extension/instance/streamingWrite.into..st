"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: xtreams
"
streamingWrite: anInteger into: aWriteStream
	anInteger timesRepeat: [self streamingWriteInto: aWriteStream].
	^anInteger
