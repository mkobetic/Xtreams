"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
contentsSpecies: aClass
	contentsSpecies := aClass.
	cache ifNotNil: [ cache recycle ].
	cache := (direct := contentsSpecies == source contentsSpecies)
		ifTrue:	[nil]
		ifFalse:	[
			source contentsSpecies newRecycled: (
				(cache notNil and: [ cache size > 0 ])
					ifTrue: [cache size]
					ifFalse: [DefaultBufferSize])]
