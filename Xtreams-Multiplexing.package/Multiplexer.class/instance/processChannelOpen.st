"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
processChannelOpen
	"The remote side has opened a new channel."

	| id buffer channel |
	id := inputUnsignedLong get.
	self log: ['received channel open: #', id printString].
	channelsMutex critical:
		[channels size < id ifTrue: [channels := channels growToAtLeast: id].
		buffer := RingBuffer on: (input contentsSpecies new: ChannelWindow).
		channel := MultiplexReadSubstream on: buffer multiplexer: self id: id.
		channels at: id put: channel].

	availableChannels writing put: channel.
	availableChannelsLock signal