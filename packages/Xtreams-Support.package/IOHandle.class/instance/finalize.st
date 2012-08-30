finalization
finalize

	semaphore ifNotNil: [Smalltalk unregisterExternalObject: semaphore].
	self unregister
