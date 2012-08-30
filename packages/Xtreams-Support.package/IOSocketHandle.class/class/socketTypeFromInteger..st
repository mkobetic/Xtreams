private - converting
socketTypeFromInteger: anInteger
	"FIXME: The mapping of socket types to integers should be in class Socket. Socket has
	class variables for this, but no accessors. Somebody please gather this into one class,
	then update or elimitate this method."

	(anInteger == TCPSocketType) ifTrue: [^ #TCP].
	(anInteger == UDPSocketType) ifTrue: [^ #UDP].
	self error: 'invalid socket type, should be ',
		TCPSocketType asString, ' or ', UDPSocketType asString