queries
isOtherEndClosed
	"Return true if this socket had the other end closed."

	handle == nil ifTrue: [^ false].
	^ (self primSocketConnectionStatus: handle) == OtherEndClosed
