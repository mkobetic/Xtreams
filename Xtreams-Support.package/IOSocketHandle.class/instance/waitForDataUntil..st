waiting
waitForDataUntil: deadline
	"Wait up until the given deadline for data to arrive. Return true if data arrives by the deadline, false if not."

	| dataArrived |
	[self isConnected & 
	 (dataArrived := self primSocketReceiveDataAvailable: handle) not
			"Connection end and final data can happen fast, so test in this order"
		and: [Time millisecondClockValue < deadline]] whileTrue: [
			self readSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].
	^ dataArrived
