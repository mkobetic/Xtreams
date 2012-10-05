instance creation
create: socketType network: netType receiveBufferSize: rcvBufSize sendBufSize: sendBufSize

	^ super new
		initialize: socketType
		network: netType
		receiveBufferSize: rcvBufSize
		sendBufferSize: sendBufSize