"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| count amount |
	substreamClosed ifTrue: [(Incomplete on: aSequenceableCollection count: 0 at: startIndex) raise].
	count := 0.
	[count < anInteger] whileTrue:
		[quota isZero ifTrue: [waitingLock wait].
		substreamClosed ifTrue: [(Incomplete on: aSequenceableCollection count: count at: startIndex) raise].
		[amount := multiplexer transmitChannelData: id write: (quota min: (anInteger - count)) from: aSequenceableCollection at: startIndex + count]
			on: Incomplete do: [:exception | (Incomplete on: aSequenceableCollection count: count + exception count at: startIndex) raise].
		count := count + amount.
		quota := quota - amount].
	^anInteger