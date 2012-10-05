queries
isWaitingForConnection
	"Return true if this socket is waiting for a connection."

	^ self connectionStatus == WaitingForConnection
