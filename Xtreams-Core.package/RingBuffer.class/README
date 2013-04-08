RingBuffer is a specialized buffer that has a fixed sized cache. The cache is treated as ring/circle, such that when we get to the end of the cache, we continue reading and writing data from the beginning of the cache. If you write more data than you have written, the unread data is lost. The readPosition and writePosition are always relative to the dataPosition, which is a hidden implementation detail.

Instance Variables
	dataPosition	<ArithmeticValue>	the position in our cache where our data starts

