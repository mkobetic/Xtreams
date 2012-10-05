primitive access
primSocketSendDone: IOSocketHandleID
	"Return true if there is no send in progress on the current IOSocketHandle."

	<primitive: 'primitiveSocketSendDone' module: 'SocketPlugin'>
	self primitiveFailed
