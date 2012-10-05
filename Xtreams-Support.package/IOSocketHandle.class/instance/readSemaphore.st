accessing
readSemaphore

	self primitiveOnlySupportsOneSemaphore
		ifTrue: [^ semaphore]
		ifFalse: [^ readSemaphore]