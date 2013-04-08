"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
contentsSpecies: aClass
	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycledDefaultSize.
	cachePosition := 0.
	cacheDataSize := 0.