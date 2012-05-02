Wraps a stream and buffers output to it based on the size of the ring-buffer it has. This is useful for doing "burst" writing, where you know exactly when you can flush the stream. To force the buffer to the underlying stream, use #flush.

Instance Variables
	buffer	<RingBuffer>	a fixed size RingBuffer to buffer up output, released when it is full or #flush/#close is sent.

