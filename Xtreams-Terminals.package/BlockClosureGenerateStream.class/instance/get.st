accessing
get
	writingSemaphore signal.
	closed ifTrue: [Incomplete zero raise].
	readingSemaphore wait.
	^current