sending-receiving
receiveDataInto: aStringOrByteArray
	"Receive data into the given buffer and return the number of bytes received. Note the
	given buffer may be only partially filled by the received data."

	^ self receiveDataInto: aStringOrByteArray
						startingAt: 1
						count: aStringOrByteArray size

