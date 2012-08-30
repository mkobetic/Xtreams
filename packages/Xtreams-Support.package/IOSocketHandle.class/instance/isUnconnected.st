queries
isUnconnected
	"Return true if this socket's state is Unconnected."

	^ self connectionStatus == Unconnected
