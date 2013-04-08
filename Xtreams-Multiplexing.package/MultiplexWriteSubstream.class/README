MultiplexWriteSubstream is a write channel, which sends data through a multiplexer, up to its quota, which is granted more bytes once the remote side indicates it wants more from this channel.

Instance Variables
	id	<Integer>	the channel id
	multiplexer	<Multiplexer>	the multiplexer we run on top of
	quota		<Integer>		the number of bytes we're allowed to transmit before we must wait for a 'remote side wants more' message.
	waitingLock	<Semaphore>	a lock we wait on when we've exhausted our quota
	substreamClosed	<Boolean>	indicates that the stream was closed (remotely or locally)

