"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp
	super setUp.
	timeoutDuration ifNil: [timeoutDuration := 3 seconds].
	sockets := OS.SocketAccessor phonyPair.
	self
		server: [server := Multiplexer on: sockets first]
		client: [client := Multiplexer on: sockets last].

	"Enable if the tests fail, to see what the traffic is."
"	server logger: Transcript writing.
	client logger: Transcript writing"