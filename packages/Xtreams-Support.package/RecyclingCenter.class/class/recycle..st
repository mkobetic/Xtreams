recycling
recycle: aCollection
	aCollection == nil ifTrue: [^nil].
	aCollection isFixedArgument
		ifTrue:
			[aCollection size == 1 ifTrue: [fixedspace1 recycle1: aCollection].
			aCollection size == cacheSize ifTrue: [fixedspaceN recycle: aCollection]]
		ifFalse:
			[aCollection size == 1 ifTrue: [objectspace1 recycle1: aCollection].
			aCollection size == cacheSize ifTrue: [objectspaceN recycle: aCollection]]