"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - transmitting
"
transmitChannelOpen: id
	"Tell the remote side we are opening a channel."

	self log: ['transmit channel open: #', id printString].
	outputMutex critical:
		[outputUnsignedLong put: ChannelOpen.
		outputUnsignedLong put: id.
		output flush]