primitive access
primSocketReceiveDataAvailable: IOSocketHandleID
	"Return true if data may be available for reading from the current IOSocketHandle."

	<primitive: 'primitiveSocketReceiveDataAvailable' module: 'SocketPlugin'>
	self primitiveFailed
