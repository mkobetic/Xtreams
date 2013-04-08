"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp

	(OSHandle currentOS = #win32) ifTrue: [self error: 'There are no domain sockets on Windows!' ].
	sockets := SocketAccessor openPair.
	input := sockets first.
	output := sockets last.