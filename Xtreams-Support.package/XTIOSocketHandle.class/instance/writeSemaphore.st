accessing
writeSemaphore

	self primitiveOnlySupportsOneSemaphore
		ifTrue: [^ semaphore]
		ifFalse: [^ writeSemaphore]