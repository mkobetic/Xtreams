primitive access
primSocketError: IOSocketHandleID
	"Return an integer encoding the most recent error on this IOSocketHandle. Zero means no error."

	<primitive: 'primitiveSocketError' module: 'SocketPlugin'>
	self primitiveFailed
