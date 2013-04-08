"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
processChannelMore
	"The remote side wants more data for a channel."

	| id channel |
	id := inputUnsignedLong get.
	channelsMutex critical:
		[(channel := channels at: id) == nil ifTrue: [
			self log: ['received channel more (on closed channel): #', id printString].
			^self].
		self log: ['received channel more: #', id printString].
		channel refill]