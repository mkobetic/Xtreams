"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	substreamClosed ifTrue: [Incomplete zero raise].
	quota isZero ifTrue: [waitingLock wait].
	substreamClosed ifTrue: [Incomplete zero raise].
	multiplexer transmitChannelData: id put: anObject