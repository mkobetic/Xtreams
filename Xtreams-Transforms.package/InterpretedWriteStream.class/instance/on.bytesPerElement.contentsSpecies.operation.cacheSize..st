"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aWriteStream bytesPerElement: anInteger contentsSpecies: aClass operation: aBlock cacheSize: aSize
	super on: aWriteStream.
	cacheSize := aSize.
	elementSize := anInteger.
	contentsSpecies := aClass.
	operation := aBlock.
	cache := InterpretedBytes newRecycled: ((elementSize * cacheSize) max: DefaultBufferSize)
