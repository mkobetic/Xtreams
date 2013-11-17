"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aReadStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	super on: aReadStream.
	cacheSize := aSize.
	elementSize := anInteger.
	contentsSpecies := aClass.
	operation := aBlock.
	cache := InterpretedBytes newRecycled: ((elementSize * cacheSize) max: DefaultBufferSize)
