accessing
semaphore
	"A semaphore which may be signalled by external events to support
	asynchronous input and output handling."

	^semaphore ifNil: [semaphore := Semaphore new]