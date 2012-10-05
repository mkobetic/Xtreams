primitive access
primSocketRemoteAddress: IOSocketHandleID
	"Return the remote host address for this IOSocketHandle, or zero if no connection has been made."

	<primitive: 'primitiveSocketRemoteAddress' module: 'SocketPlugin'>
	self primitiveFailed
