datagrams
sendData: aStringOrByteArray toHost: hostAddress port: portNumber
	"Send a UDP packet containing the given data to the specified host/port."

	self primitiveOnlySupportsOneSemaphore ifTrue:
		[self setPeer: hostAddress port: portNumber.
		^self sendData: aStringOrByteArray].
	^self sendUDPData: aStringOrByteArray toHost: hostAddress port: portNumber