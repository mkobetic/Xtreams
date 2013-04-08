"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - transmitting
"
transmitChannelData: id put: anObject
	"Tell the remote side we have some data for a channel. It is the responsibility of MultiplexWriteSubstream not to go over its quota."

	self log: ['transmit channel data: #', id printString, ' size: 1 bytes'].
	outputMutex critical:
		[outputUnsignedLong put: id.
		outputUnsignedLong put: 1.
		output put: anObject.
		output flush.
		Processor yield]