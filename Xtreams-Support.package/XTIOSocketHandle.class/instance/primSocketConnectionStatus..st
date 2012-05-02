primitive access
primSocketConnectionStatus: IOSocketHandleID
	"Return an integer reflecting the connection status of this IOSocketHandle. For a list of possible values, see the comment in the 'initialize' method of this class. If the primitive fails, return a status indicating that the IOSocketHandle handle is no longer valid, perhaps because the Squeak image was saved and restored since the IOSocketHandle was created. (IOSocketHandles do not survive snapshots.)"

	<primitive: 'primitiveSocketConnectionStatus' module: 'SocketPlugin'>
	^ InvalidSocket
