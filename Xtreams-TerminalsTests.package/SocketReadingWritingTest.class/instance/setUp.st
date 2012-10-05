initialize-release
setUp

	| listener sync |
	Socket initializeNetwork.
	sync := Semaphore new.
	listener := Socket newTCP.
	[	listener listenOn: 9999 backlogSize: 10.
		[	output := Socket newTCP.
			output connectTo: #[127 0 0 1] port: 9999 waitForConnectionFor: 2.
			sync signal.
		] fork.	
		input := (listener waitForAcceptFor: 1).
		sync wait.
	] ensure: [ listener close ].

	input := input reading.
	output := output writing.