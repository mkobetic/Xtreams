instance creation
create: socketType network: netType

	^ self create: socketType network: netType receiveBufferSize: 8000 sendBufSize: 8000
