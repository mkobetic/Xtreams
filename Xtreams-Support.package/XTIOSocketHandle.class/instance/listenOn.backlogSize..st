connection open-close
listenOn: portNumber backlogSize: backlog
	"Listen for a connection on the given port.
	If this method succeeds, #accept may be used to establish a new connection"

	| result |
	self isUnconnected
		ifFalse: [self error:
			'Socket status must be Unconnected before listening for a new connection'].
	result := self primSocket: handle listenOn: portNumber backlogSize: backlog.
	^ result
