primitive access
primSocketLocalPort: IOSocketHandleID
	"Return the local port for this IOSocketHandle, or zero if no port has yet been assigned."

	<primitive: 'primitiveSocketLocalPort' module: 'SocketPlugin'>
	self primitiveFailed
