Converts written elements using the provided conversion block. Optimizes bulk writes by batching the conversion results, allowing the destination stream to perform bulk writes as well.

Instance Variables
	block	<BlockClosure> collecting block (same style as collect: blocks)
	cache	<SequenceableCollection> caches results after transformation so that they can be bulk written too

