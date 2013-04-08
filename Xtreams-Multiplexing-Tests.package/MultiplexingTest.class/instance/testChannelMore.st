"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testChannelMore
	| phase1 result |
	phase1 := Semaphore new.
	self
		server: [ | out |
			out := server getOutputChannel.
			out write: #[ 1 2 3 4 5 ].
			phase1 wait.
			1 milliseconds wait.
			out write: #[ 6 7 8 9 0 ].
			out close]
		client: [
			phase1 signal.
			result := client getInputChannel rest.
			self assert: result = #[ 1 2 3 4 5 6 7 8 9 0 ] ]