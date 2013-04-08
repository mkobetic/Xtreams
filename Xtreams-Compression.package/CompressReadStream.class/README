Treats the bytes (0..255) produced by the source stream as ZLib compressed content and decompresses (inflates) them.

Since the stream cannot estimate how much compressed content it needs to read in order to provide requested amount of bytes, some amount of read-ahead is likely to occur. This doesn't change the behavior of the API, but affects the overall state of the stream stack.

Instance Variables
	input	<ByteArray> fixed-space input buffer shared with zlib
	output	<ByteArray> fixed-space output buffer shared with zlib
	compression	<Compression>
	unconsumedOut	<SmallInteger> how much of output was not processed yet
	unconsumedIn	<SmallInteger> how much of input was not processed yet

