primitive access
primAcceptFrom: IOSocketHandleID receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex
	"Create and return a new IOSocketHandle based on accepting the connection from the given listening socket"

	<primitive: 'primitiveSocketAccept' module: 'SocketPlugin'>
	^self primitiveFailed