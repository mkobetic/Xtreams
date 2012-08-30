connection open-close
listenOn: port
	"Listen for a connection on the given port. This operation will return immediately;
	follow it with waitForConnectionUntil: to wait until a connection is established."

	| result |
	self isUnconnected
		ifFalse: [self error:
			'Socket status must be Unconnected before listening for a new connection'].
	result := self primSocket: handle listenOn: port.
	^ result
