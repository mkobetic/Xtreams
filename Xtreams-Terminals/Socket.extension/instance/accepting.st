"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: converting
"
accepting
	"Return a read stream that produces new sockets from incoming connections."

	"^      ReadStream"

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
