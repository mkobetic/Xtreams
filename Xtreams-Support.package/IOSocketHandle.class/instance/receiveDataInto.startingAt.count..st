sending-receiving
receiveDataInto: buf startingAt: index count: num
	"Receive up to num bytes of data into a buffer starting at the given index. Return
	the number of bytes read or zero if no data is available."

	^ self primSocket: handle
			receiveDataInto: buf
			startingAt: index
			count: num