datagrams
setPort: port
	"Associate a local port number with a UDP socket.  Not applicable to TCP sockets."

	self primSocket: handle setPort: port.
