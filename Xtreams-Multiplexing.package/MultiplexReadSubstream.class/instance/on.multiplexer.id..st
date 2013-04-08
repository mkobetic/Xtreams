"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aSource multiplexer: aMultiplexer id: anInteger
	self on: aSource.
	id := anInteger.
	multiplexer := aMultiplexer.
	waitingLock := Semaphore new.
	stateLock := Semaphore forMutualExclusion.
	substreamClosed := false