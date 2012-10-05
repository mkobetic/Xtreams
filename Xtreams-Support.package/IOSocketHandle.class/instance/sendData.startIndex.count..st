sending-receiving
sendData: aStringOrByteArray startIndex: index count: num
	"Send data to the remote host through the given socket starting with the given
	byte index of the given byte array. The data sent is 'pushed' immediately.
	Return the number of bytes of data actually sent; any remaining data should
	be re-submitted for sending after the current send operation has completed."

	^self primSocket: handle
			sendData: aStringOrByteArray
			startIndex: index
			count: num