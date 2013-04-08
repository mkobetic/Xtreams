"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testBidirectionalMarshaling
	| serverInput serverOutput serverMarshaler clientInput clientOutput clientMarshaler |
	self
		server: [
			serverMarshaler := ObjectMarshaler new.
			serverOutput := server getOutputChannel.
			serverInput := server getInputChannel.

			"When debugging, BlockClosures that are normally clean, become full copies, so there is an outerContext which will pull in a LOT of data, which is not what we want in the test. So we create the block closure from a string instead."
			(serverOutput marshaling: serverMarshaler) put: (Kernel.Compiler evaluate: '[3 + 4]').
			self assert: (serverInput marshaling: serverMarshaler) get = 7]
		client: [
			clientMarshaler := ObjectMarshaler new.
			clientInput := client getInputChannel.
			clientOutput := client getOutputChannel.

			(clientOutput marshaling: clientMarshaler) put:
				(clientInput marshaling: clientMarshaler) get value]