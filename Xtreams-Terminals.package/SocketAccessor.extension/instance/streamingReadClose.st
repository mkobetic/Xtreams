"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
streamingReadClose

	[	self shutdown: 0
	] on: OS.OsError do: [ :ex |
		" Various kinds of OsErrors can be raised by shutdown.
		OsIllegalOperation can be provoked like this:
		""	| sockets |
			sockets := OS.SocketAccessor phonyPair.
			[	sockets first shutdown: 1.
				sockets first shutdown: 0.
				sockets last shutdown: 1.
				sockets last shutdown: 0.
			] ensure: [ sockets do: #close ]
		"" OsError can be provoked like this
		""	| sockets |
			sockets := OS.SocketAccessor phonyPair.
			[	sockets first close.
				sockets first shutdown: 0.
			] ensure: [ sockets do: #close ]
		"  ]