"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - transmitting
"
transmitChannelClose: id
	"Tell the remote side we are closing a channel."

	self log: ['transmit channel close: #', id printString].
	outputMutex critical:
		[outputUnsignedLong put: ChannelClose.
		outputUnsignedLong put: id.
		output flush].
	channelsMutex critical: [channels at: id put: nil]