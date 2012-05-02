accessing
get
	cachePosition < cacheDataSize ifFalse: [
		cachePosition := 0.
		cacheDataSize := source readInto: cache.
		cacheDataSize isZero ifTrue: [ self incompleteRead: Incomplete zero ] ].
	^cache at: (cachePosition := cachePosition + 1)