primitive access
primSocket: IOSocketHandleID setPort: port
	"Set the local port associated with a UDP IOSocketHandle.
	Note: this primitive is overloaded.  The primitive will not fail on a TCP IOSocketHandle, but
	the effects will not be what was desired.  Best solution would be to split IOSocketHandle into
	two subclasses, TCPIOSocketHandle and UDPIOSocketHandle."

	<primitive: 'primitiveSocketListenWithOrWithoutBacklog' module: 'SocketPlugin'>
	self primitiveFailed
