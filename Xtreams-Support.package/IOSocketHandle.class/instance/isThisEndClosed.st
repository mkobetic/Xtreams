queries
isThisEndClosed
	"Return true if this socket had the this end closed."

	handle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: handle) == ThisEndClosed
