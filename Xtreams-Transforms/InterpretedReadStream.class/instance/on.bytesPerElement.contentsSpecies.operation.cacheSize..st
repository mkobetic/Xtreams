"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aReadStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	super on: aReadStream.
	cacheSize := aSize.
	elementSize := anInteger.
	contentsSpecies := aClass.
	operation := aBlock.
	cache := InterpretedBytes newRecycled: ((elementSize * cacheSize) max: DefaultBufferSize)