primitive access
primAcceptFrom: ioSocketHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex readSemaIndex: aReadSema writeSemaIndex: aWriteSema
	"Create and return a new ioSocketHandle based on accepting the connection from the given listening socket"

	<primitive: 'primitiveSocketAccept3Semaphores' module: 'SocketPlugin'>
	primitiveOnlySupportsOneSemaphore := true.
	^self primAcceptFrom: ioSocketHandle receiveBufferSize: rcvBufSize sendBufSize: sndBufSize semaIndex: semaIndex 