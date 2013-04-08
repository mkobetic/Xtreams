A multiplexer protocol which takes an input and an output stream, connected to another remote multiplexer.

Instance Variables
	identitiesNext	<Integer>	the next channel identity to be allocated
	input	<ReadStream>	the input stream the protocol reads from
	inputUnsignedLong	<InterpretedReadStream>	the input stream as unsigned little endian longs
	output	<WriteStream>	the output stream the protocol writes to
	outputUnsignedLong	<InterpretedWriteStream>	the output stream as unsigned little endian longs
	outputMutex	<Semaphore>	a mutex to ensure channel write streams do not clobber each other when transmitting data
	availableChannels	<SharedQueue>	input channels that have been initiated by the remote side but not yet accepted by this side
	availableChannelsLock	<Semaphore>	a lock to protect registering from consuming channels
	logger	<WriteStream>	a write stream to record protocol messages to
	process	<Process>	the process that reads packets from input
	channels	<(Array of: MultiplexReadSubstream) | (Array of: MultiplexWriteSubstream)>	the active registered channels
	channelsMutex	<Semaphore>	a mutex that protects the channels during register/deregister/lookup
	version	<Integer>	the version of the protocol we're running as, negotiated with the remote side

Shared Variables
	ProtocolVersion	<Integer>	the maximum supported protocol version for this implementation. An actual running multiplexer may have run to at a lower version or reject the connection entirely.
	ChannelOpen	<Integer>	the protocol command to open a new substream channel
	ChannelClose	<Integer>	the protocol command to close an existing substream channel
	ChannelMore	<Integer>	the protocol command to request more data for a substream channel
	ChannelWindow	<integer>	the default size of the channel buffer window