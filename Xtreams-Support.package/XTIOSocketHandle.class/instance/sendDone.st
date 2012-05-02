queries
sendDone
	"Return true if the most recent send operation on this socket has completed."

	^ self primSocketSendDone: handle
