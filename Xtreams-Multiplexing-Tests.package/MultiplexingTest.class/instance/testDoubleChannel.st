"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDoubleChannel
	| out1 out2 in1 in2 result1 result2 |
	self
		server: [
			out1 := server getOutputChannel.
			out1 write: #[ 1 2 ].
			out2 := server getOutputChannel.
			out1 write: #[ 3 4 ].
			out2 write: #[ 5 6 7 8 ].
			out1 close.
			out2 close]
		client: [
			in1 := client getInputChannel.
			in2 := client getInputChannel.
			result2 := in2 rest.
			result1 := in1 rest.
			self assert: result2 = #[ 5 6 7 8 ].
			self assert: result1 = #[ 1 2 3 4 ] ]