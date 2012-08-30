Used to write to BlockableIOAccessors (e.g sockets or pipes). This is a binary stream (consumes bytes/ByteArrays).

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
	contentsSpecies	<Class> species for collections of elements of this stream

