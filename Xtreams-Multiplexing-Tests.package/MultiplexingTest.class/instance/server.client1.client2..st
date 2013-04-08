"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
server: serverBlock client1: client1Block client2: client2Block
	"For tests that must be able to write and read at the same time, where they may block on each."

	|	timeout timeoutTimer
		serverFailure serverProcess serverLock
		client1Failure client1Process client1Lock
		client2Failure client2Process client2Lock |

	serverLock := Semaphore new.
	client1Lock := Semaphore new.
	client2Lock := Semaphore new.
	timeout := serverFailure := client1Failure := client2Failure := false.
	serverProcess :=
		[serverBlock on: Error, SUnit.FailedAssertion do: [:exception |
			serverLock signal.
			serverFailure := true.
			exception pass].
		serverLock signal] newProcess.
	serverProcess name: 'test-server'.

	client1Process :=
		[client1Block on: Error, SUnit.FailedAssertion do: [:exception |
			client1Lock signal.
			client1Failure := true.
			exception pass].
		client1Lock signal] newProcess.
	client1Process name: 'test-client1'.

	client2Process :=
		[client2Block on: Error, SUnit.FailedAssertion do: [:exception |
			client2Lock signal.
			client2Failure := true.
			exception pass].
		client2Lock signal] newProcess.
	client2Process name: 'test-client2'.

	serverProcess resume.
	client1Process resume.
	client2Process resume.

	timeoutTimer := Timer after: timeoutDuration do:
		[serverProcess terminate.
		client1Process terminate.
		client2Process terminate.
		timeout := true.
		serverLock signal.
		client1Lock signal.
		client2Lock signal].

	[serverLock wait.
	client1Lock wait.
	client2Lock] ensure: [
		timeoutTimer stop.
		self deny: serverFailure.
		self deny: client1Failure.
		self deny: client2Failure.
		self deny: timeout]