initialize-destroy
destroy
	"Destroy this socket. Its connection, if any, is aborted and its resources are freed. 
	Do nothing if the socket has already been destroyed (i.e., if its socketHandle is nil)."

	self isValid
		ifTrue: 
			[self primSocketDestroy: self handle].
	Smalltalk unregisterExternalObject: semaphore.
	Smalltalk unregisterExternalObject: readSemaphore.
	Smalltalk unregisterExternalObject: writeSemaphore.
	handle := nil.
	readSemaphore := writeSemaphore := semaphore := nil
