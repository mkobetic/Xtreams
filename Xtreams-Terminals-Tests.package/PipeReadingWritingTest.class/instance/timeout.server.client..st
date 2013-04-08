"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
timeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	|	timeout
		serverSuccess serverProcess serverLock
		clientSuccess clientProcess clientLock|

	timeout := false.
	serverLock := Semaphore new.
	clientLock := Semaphore new.
	serverSuccess := clientSuccess := false.
	serverProcess := [serverSuccess := serverBlock value. serverLock signal] fork.
	clientProcess := [clientSuccess := clientBlock value. clientLock signal] fork.

	Core.Timer after: timeoutDuration do:
		[serverProcess terminate.
		output ifNotNil: [ output close ].
		clientProcess terminate.
		input ifNotNil: [ input close ].
		timeout := true.
		serverLock signal.
		clientLock signal].
	serverLock wait.
	clientLock wait.

	self assert: serverSuccess.
	self assert: clientSuccess.
	self deny: timeout