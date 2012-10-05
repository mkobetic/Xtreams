primitive access
primSocketLocalAddress: IOSocketHandleID
	"Return the local host address for this IOSocketHandle."

	<primitive: 'primitiveSocketLocalAddress' module: 'SocketPlugin'>
	self primitiveFailed
