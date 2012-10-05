finalization
finalize

	super finalize.
	Smalltalk unregisterExternalObject: readSemaphore.
	Smalltalk unregisterExternalObject: writeSemaphore.
	self isValid
		ifTrue:
			[self primSocketDestroyGently: handle]

