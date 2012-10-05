primitive access
primSocketDestroy: IOSocketHandleID
	"Release the resources associated with this IOSocketHandle. If a connection is open, it is aborted."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>
	self primitiveFailed
