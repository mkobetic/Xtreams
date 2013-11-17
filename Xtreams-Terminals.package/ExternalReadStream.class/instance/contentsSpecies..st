"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
contentsSpecies: aClass
	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycled: DefaultBufferSize.
	cachePosition := 0.
	cacheDataSize := 0.
