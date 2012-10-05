initialize-release
contentsSpecies: aClass
	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycledDefaultSize.
	cachePosition := 0.
	cacheDataSize := 0.