"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
contentsSpecies: aClass

	cache ifNotNil: [ cache recycle ].
	cache := aClass newRecycled: (
				(cache notNil and: [ cache size > 0 ])
					ifTrue: [cache size]
					ifFalse: [DefaultBufferSize])
