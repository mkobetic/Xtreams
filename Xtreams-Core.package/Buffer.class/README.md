Buffer implements a buffering API over an in-memory cache. The cache will grow as required to fit new data in to the buffer. Two positions are kept, the read position and write position, allowing flexible usage of the buffer.

API:
	read:into:startingAt: -- reads data from the cache and moves readPosition forward
	write:into:startingAt: -- writes data into the cache and moves writePosition forward
	readSkip:/writeSkip: -- moves either readPosition or writePosition forward without changing the cache
	readPosition/readPosition:/writePosition/writePosition: -- accessors to the read/write positions
	clear -- remove all the data from the cache
	trim -- remove all the read data and all the empty space for writing in to from the cache

Instance Variables
	cache	<SequenceableCollection>	the cache for our buffer
	dataLength	<ArithmeticValue>	the amount of data in our cache, not the size of the cache
	readPosition	<ArithmeticValue>	the position within our data that we're reading from (0..dataLength)
	writePosition	<ArithmeticValue>	the position within our data that we're writing from (0..dataLength)

