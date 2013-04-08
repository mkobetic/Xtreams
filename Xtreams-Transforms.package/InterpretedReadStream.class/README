Interprets bytes from a binary source as values of preconfigured (primitive) CType, e.g. float, long etc.

Instance Variables
	elementSize	<Integer> byte size of elements of the pre-configured CType
	cache	<InterpretedBytes> caches bulk read bytes before interpreting for speed; size = elementSize * cacheSize
	cacheSize	<SmallInteger> how many elements (not bytes) do we want to cache
	operation	<BlockClosure> CType translation primitive used to read from the buffer
	contentsSpecies	<Class> collection type to use to hold collections of elements

