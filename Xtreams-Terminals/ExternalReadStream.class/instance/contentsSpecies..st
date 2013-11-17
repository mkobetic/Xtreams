"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: initialize-release
"
contentsSpecies: aClass
	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycled: DefaultBufferSize.
	cachePosition := 0.
	cacheDataSize := 0.
