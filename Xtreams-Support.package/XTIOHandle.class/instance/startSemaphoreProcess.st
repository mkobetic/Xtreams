asynchronous input
startSemaphoreProcess
	"Start a process to handle asynchronous input and output events."

	semaphore
		ifNotNil:
			[semaphore terminateProcess.
			semaphore := nil].
	self semaphore.
	[[self semaphore wait; initSignals] repeat]
		forkAt: Processor userBackgroundPriority