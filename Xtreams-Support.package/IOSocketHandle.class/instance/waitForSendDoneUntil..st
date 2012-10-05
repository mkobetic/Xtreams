waiting
waitForSendDoneUntil: deadline
	"Wait up until the given deadline for the current send operation to complete. Return true if it completes by the deadline, false if not."

	| sendDone |
	[self isConnected & (sendDone := self primSocketSendDone: handle) not
			"Connection end and final data can happen fast, so test in this order"
		and: [Time millisecondClockValue < deadline]] whileTrue: [
			self writeSemaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].
	^ sendDone