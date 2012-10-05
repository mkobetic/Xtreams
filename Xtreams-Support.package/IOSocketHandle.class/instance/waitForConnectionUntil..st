waiting
waitForConnectionUntil: deadline
	"Wait up until the given deadline for a connection to be established. Return true if it is established by the deadline, false if not."

	[(self isWaitingForConnection) and: [Time millisecondClockValue < deadline]]
		whileTrue: [semaphore waitTimeoutMSecs: (deadline - Time millisecondClockValue)].
	^ self isConnected
