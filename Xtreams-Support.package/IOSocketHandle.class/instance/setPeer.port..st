datagrams
setPeer: hostAddress port: port
	"Set the default send/recv address. Similar to connectTo:port:, but bypasses the
	check for isConnected, since a UDP socket appears connected always."

	self primSocket: handle connectTo: hostAddress port: port.