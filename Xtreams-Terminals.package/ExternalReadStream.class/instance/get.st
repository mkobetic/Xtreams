"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	cachePosition < cacheDataSize ifFalse: [
		cachePosition := 0.
		cacheDataSize := (1 max: self bytesForRead) min: cache size.
		cacheDataSize := self readBytes: cacheDataSize into: cache startingAt: 1.
		cacheDataSize isZero ifTrue: [ self incompleteRead: Incomplete zero ] ].
	^cache at: (cachePosition := cachePosition + 1)
