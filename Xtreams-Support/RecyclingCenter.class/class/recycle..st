"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: recycling
"
recycle: aCollection
	aCollection == nil ifTrue: [^nil].
	aCollection isFixedArgument
		ifTrue:
			[aCollection size == 1 ifTrue: [fixedspace1 recycle: aCollection].
			aCollection size == cacheSize ifTrue: [fixedspaceN recycle: aCollection]]
		ifFalse:
			[aCollection size == 1 ifTrue: [objectspace1 recycle: aCollection].
			aCollection size == cacheSize ifTrue: [objectspaceN recycle: aCollection]]
