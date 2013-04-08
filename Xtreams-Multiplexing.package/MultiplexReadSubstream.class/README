MultiplexReadSubstream is a read channel, which receives data in to its buffer from a Multiplexer.

Instance Variables
	id	<Integer>	the channel id
	multiplexer	<Multiplexer>	the multiplexer we run on top of
	stateLock	<Semaphore>	a lock to prevent incoming packets from the multiplexer disrupting the read operation of this stream
	substreamClosed	<Boolean>	indicates that the stream was closed (remotely or locally)
	waitingLock	<Semaphore>	a lock we wait on when expecting data to be sent from the remote side

