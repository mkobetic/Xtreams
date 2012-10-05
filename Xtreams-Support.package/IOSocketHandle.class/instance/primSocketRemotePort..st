primitive access
primSocketRemotePort: IOSocketHandleID
	"Return the remote port for this IOSocketHandle, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemotePort' module: 'SocketPlugin'>
	self primitiveFailed
