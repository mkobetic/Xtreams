blocking utilities
concurrentTimeout: timeoutDuration server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each.
	 Sockets, Pipes have an operating system buffer which dictates its bandwidth."

	|	timeout
		serverSuccess serverProcess serverLock
		clientSuccess clientProcess clientLock
		end |

	timeout := false.
	serverLock := Semaphore new.
	clientLock := Semaphore new.
	serverSuccess := clientSuccess := false.
	serverProcess := [serverSuccess := serverBlock value. serverLock signal] newProcess.
	clientProcess := [clientSuccess := clientBlock value. clientLock signal] newProcess.

	end := DateAndTime now + timeoutDuration.
	serverProcess priority: Processor activeProcess priority - 1; resume.
	clientProcess priority: Processor activeProcess priority - 1; resume.

	((serverLock waitTimeoutMSecs: (end - DateAndTime now) asMilliSeconds) or: [
		clientLock waitTimeoutMSecs: (end - DateAndTime now) asMilliSeconds])
			ifTrue: [
				serverProcess terminate.
				output ifNotNil: [output close].
				clientProcess terminate.
				input ifNotNil: [input close].
				timeout := true ].

	self assert: serverSuccess.
	self assert: clientSuccess.
	self deny: timeout