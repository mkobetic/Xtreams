Converts elements being read using the provided conversion block. When the contentSpecies of the source doesn't match the desired contentSpecies of this stream, we optimize bulk reads by reading into an internal buffer.

Instance Variables
	block	<BlockClosure> collecting block (same style as collect: blocks)
	cache	<SequenceableCollection | nil> caches elements before transformation when direct is false
	contentsSpecies	<Class> species for collections of elements of this stream
	direct	<Boolean> are we using an intermediate buffer (when source's contentSpecies doesn't match ours)

