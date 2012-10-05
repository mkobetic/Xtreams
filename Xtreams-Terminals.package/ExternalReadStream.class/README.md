Used to read from BlockableIOAccessors (e.g sockets or pipes). Elements are read-ahead but only what's available. This is a binary stream (produces bytes/ByteArrays).

{{{
	[ :in :out |
		[	out writing write: 'Hello'; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: SocketAccessor openPair
}}}
{{{
	[ :in :out |
		[	out writing write: 'Hello'; close.
			in reading read: 5
		] ensure: [ in close. out close ]
	] valueWithArguments: OSSystemSupport concreteClass pipeAccessorClass openPair
}}}

Instance Variables
	cache	<ByteArray | ByteString> read-ahead buffer
	cachePosition	<SmallInteger> position in the buffer
	cacheDataSize	<SmallInteger> size of valid data in the buffer

