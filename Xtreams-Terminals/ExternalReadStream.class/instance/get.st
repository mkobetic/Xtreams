"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	cachePosition < cacheDataSize ifFalse: [
		cachePosition := 0.
		cacheDataSize := (1 max: self bytesForRead) min: cache size.
		cacheDataSize := self readBytes: cacheDataSize into: cache startingAt: 1.
		cacheDataSize isZero ifTrue: [ self incompleteRead: Incomplete zero ] ].
	^cache at: (cachePosition := cachePosition + 1)
