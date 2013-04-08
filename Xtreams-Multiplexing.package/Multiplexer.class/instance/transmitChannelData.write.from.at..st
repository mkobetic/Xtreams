"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - transmitting
"
transmitChannelData: id write: anInteger from: aSequenceableCollection at: startIndex
	"Tell the remote side we have some data for a channel. It is the responsibility of MultiplexWriteSubstream not to go over its quota."

	| written |
	self log: ['transmit channel data: #', id printString, ' size: ', anInteger printString, ' bytes'].
	outputMutex critical:
		[outputUnsignedLong put: id.
		outputUnsignedLong put: anInteger.
		written := output write: anInteger from: aSequenceableCollection at: startIndex.
		output flush.
		Processor yield].
	^written