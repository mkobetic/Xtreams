primitive access
primSocketDestroyGently: IOSocketHandleID
	"Release the resources associated with this IOSocketHandle. If a connection is open, it is aborted.
	Do not fail if the receiver is already closed."

	<primitive: 'primitiveSocketDestroy' module: 'SocketPlugin'>
