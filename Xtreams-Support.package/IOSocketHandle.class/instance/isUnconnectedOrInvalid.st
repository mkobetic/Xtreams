queries
isUnconnectedOrInvalid
	"Return true if this socket is completely disconnected or is invalid."

	| status |
	status := self connectionStatus.
	^ (status == Unconnected) | (status == InvalidSocket)
