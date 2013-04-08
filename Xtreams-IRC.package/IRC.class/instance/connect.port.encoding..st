"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: connect / disconnect
"
connect: hostname port: port encoding: anEncoding
	| socket |
	output == nil ifFalse: [self error: 'already connected'].

	"Handle the PING/PONG challenge"
	self when: #PING do: [:origin :args | self pong: args first].

	"Respond to various default CTCP requests"
	self when: #PRIVMSG_VERSION do: [:origin :args | self notice_version: (self nickname: origin) comment: 'Xtreams IRC Client 0.1'].
	self when: #PRIVMSG_SOURCE do: [:origin :args | self notice_source: (self nickname: origin) comment: 'http://www.cincomsmalltalk.com'].
	self when: #PRIVMSG_TIME do: [:origin :args | self notice_time: (self nickname: origin)].
	self when: #PRIVMSG_PING do: [:origin :args | self notice_ping: (self nickname: origin)].

	socket := OS.SocketAccessor newTCPclientToHost: hostname port: port.
	mutex := Semaphore forMutualExclusion.
	output := (socket writing encoding: anEncoding) setLineEndCRLF.

	"The following process will self-terminate when the socket disconnects."
	[self receiving: socket encoding: anEncoding] fork
		name: 'irc connection to: ', hostname, ':', port printString