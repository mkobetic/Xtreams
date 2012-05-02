*Xtreams-Terminals
accepting
	"Return a read stream that produces new sockets from incoming connections."

	"^	ReadStream"

	"Listen for connections and close those connections immediately.
	| socket |
	socket := SocketAccessor newTCP.
	socket listenFor: 1.
	[socket acceping do: [:client | client close]]
		ensure: [socket close]
	"

	^[self accept] reading
		closeBlock: [self close];
		yourself