initialize - release
initialize

	self register.
	semaphore ifNotNil: [semaphore terminateProcess].
"	self startSemaphoreProcess"
