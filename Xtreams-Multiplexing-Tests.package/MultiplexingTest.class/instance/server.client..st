"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: utilities
"
server: serverBlock client: clientBlock
	"For tests that must be able to write and read at the same time, where they may block on each."

	|	timeout timeoutTimer
		serverFailure serverProcess serverLock serverException
		clientFailure clientProcess clientLock clientException |

	serverLock := Semaphore new.
	clientLock := Semaphore new.
	timeout := serverFailure := clientFailure := false.
	serverProcess :=
		[serverBlock on: Error, SUnit.FailedAssertion do: [:exception |
			serverLock signal.
			serverException := exception.
			serverFailure := true.
			exception pass].
		serverLock signal] newProcess.
	serverProcess name: 'test-server'.

	clientProcess :=
		[clientBlock on: Error, SUnit.FailedAssertion do: [:exception |
			clientLock signal.
			clientException := exception.
			clientFailure := true.
			exception pass].
		clientLock signal] newProcess.
	clientProcess name: 'test-client'.

	serverProcess resume.
	clientProcess resume.

	timeoutTimer := Timer after: timeoutDuration do:
		[serverProcess terminate.
		clientProcess terminate.
		timeout := true.
		serverLock signal.
		clientLock signal].

	[serverLock wait.
	clientLock wait] ensure: [
		timeoutTimer stop.
		self deny: serverFailure.
		self deny: clientFailure.
		self deny: timeout]