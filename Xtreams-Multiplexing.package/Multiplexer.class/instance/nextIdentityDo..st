"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
nextIdentityDo: aBlock
	"Identities will tend toward moving upwards from the minimum. Identities will be re-used eventually, when the current sized substreams equals the next identity. If there are no free slots, the substreams is grown. It is possible for a false 'give me more data' signal to be sent to a write substream if an identity is re-used. The chances of this happening are low and if it does happen, the consequences are that the stream will get a slightly higher quota, temporarily."

	channelsMutex critical: [
		[identitiesNext <= channels size] whileTrue: [
			(channels at: identitiesNext) isNil ifTrue: [^channels at: identitiesNext put: (aBlock value: identitiesNext)].
			identitiesNext := identitiesNext + 1].
		identitiesNext := self minimumIdentity.
		[identitiesNext <= channels size] whileTrue: [
			(channels at: identitiesNext) isNil ifTrue: [^channels at: identitiesNext put: (aBlock value: identitiesNext)].
			identitiesNext := identitiesNext + 1].
		identitiesNext >= self maximumIdentity ifTrue: [self error: 'identities exhausted'].
		channels changeSizeTo: channels size + 32768.
		^channels at: identitiesNext put: (aBlock value: identitiesNext)]