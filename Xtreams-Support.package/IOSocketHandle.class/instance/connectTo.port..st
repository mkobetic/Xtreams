connection open-close
connectTo: hostAddress port: port
	"Initiate a connection to the given port at the given host address. This operation will
	return immediately; follow it with waitForConnectionUntil: to wait until the connection
	is established."

	self isUnconnected
		ifFalse: [self error: 'Socket status must be Unconnected before opening a new connection'].
	self primSocket: handle connectTo: hostAddress port: port.