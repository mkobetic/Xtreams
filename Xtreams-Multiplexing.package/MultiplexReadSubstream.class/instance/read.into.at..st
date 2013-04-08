"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |
	anInteger isZero ifTrue: [^0].
	count := 0.
	[count < anInteger] whileTrue: [
		stateLock wait.
		[amount := source read: anInteger - count into: aSequenceableCollection at: startIndex + count.
		stateLock signal]
			on: Incomplete do: [:exception |
				substreamClosed ifTrue: [
					stateLock signal.
					(Incomplete on: aSequenceableCollection count: count + exception count at: startIndex) raise].

				"Request more data from the remote side."
				multiplexer transmitChannelMore: id.

				"More data cannot signal waitingLock until stateLock is unlocked. We know we have fully consumed all the data in the buffer and that until stateLock is unlocked, waitingLock cannot be signalled. waitingLock may have been signalled multiple times before we locked stateLock though, so we must consume the excessSignals."
				waitingLock excessSignals timesRepeat: [waitingLock wait].

				"Release the stateLock so that incoming data can signal waitingLock at least once."
				stateLock signal.
				waitingLock wait.

				amount := exception count].
		count := count + amount].
	^anInteger