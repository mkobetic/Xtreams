"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testSingleChannelGet
	| output input result phase1 |
	phase1 := Semaphore new.
	self
		server: [
			output := server getOutputChannel.
			phase1 wait.
			10 timesRepeat: [output put: 1].
			output close]
		client: [
			result := ByteArray new writing.
			input := client getInputChannel.
			phase1 signal.
			10 timesRepeat: [result put: input get].
			result := result conclusion.
			self assert: result = #[ 1 1 1 1 1 1 1 1 1 1 ] ]