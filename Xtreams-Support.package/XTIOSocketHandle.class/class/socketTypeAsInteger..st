private - converting
socketTypeAsInteger: aSocketTypeSymbol
	"FIXME: The mapping of socket types to integers should be in class Socket. Socket has
	class variables for this, but no accessors. Somebody please gather this into one class,
	then update or elimitate this method."

	(aSocketTypeSymbol == #TCP) ifTrue: [^ TCPSocketType].
	(aSocketTypeSymbol == #UDP) ifTrue: [^ UDPSocketType].
	self error: 'invalid socket type, expected #TCP or #UDP'