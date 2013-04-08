"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
update: count from: input into: output do: action
"Run @count elements in the @input through the compression producing @output. Note that not all @count elements must be consumed with a single call (e.g. when the output is smaller than needed to consume all available input). After each compression call, the @action is invoked with amount of input consumed and amount of output produced. The @action must return a boolean indicating if another iteration with the current state of the input is required. The @action has to empty the output as it will likely be overwritten by next iteration.
	count	<SmallInteger> amount of input in the input buffer
	input	<ByteArray> input buffer
	output	<ByteArray>	output buffer
	action	<BlockClosure>	two argument block returning a boolean (see above)
	^<Boolean> is compression finished

Since input and output are not passed as arguments of the external call, they should be in fixed space to make sure they do not move before the call is made.
"
	library next_in: input; avail_in: count.
	[	library next_out: output; avail_out: output size.
		finished := inflating ifTrue: [self doInflate: false] ifFalse: [self doDeflate: false].
		action value: count - library avail_in value: output size - library avail_out
	] whileTrue.
	^finished