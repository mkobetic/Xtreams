"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
processChannelData: id
	"A packet of data is available for one a read substreams."

	| size channel |
	channelsMutex critical: [channel := channels at: id].
	size := inputUnsignedLong get.
	channel == nil ifTrue: [
		self log: ['received channel data (on closed channel): #', id printString, ' size: ', size printString, ' bytes'].
		nil writing write: size from: input.
		^self].
	self log: ['received channel data: #', id printString, ' size: ', size printString, ' bytes'].
	channel refill: size from: input