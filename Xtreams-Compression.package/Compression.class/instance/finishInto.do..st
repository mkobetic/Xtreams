"
notice: Copyright (c) 2012 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
finishInto: output do: action
"This is called at the end to make sure that all the output is produced, at this point no more input is consumed. Note that not all output elements are necessarily produced with a single compression call (e.g. when the output is smaller than needed to accommodate all the output). After each compression call, the @action is invoked with the amount amount of output produced. The @action has to empty the output as it will likely be overwritten by next iteration. The @action must return a boolean indicating if another iteration is required. However next iteration happens only if finished is false. 
	output	<ByteArray>	output buffer
	action	<BlockClosure>	one argument block invoked after the compression action with amount of output produced; must return boolean (see above)
	^<Boolean> finished

Since output is not an argument of the external call  it should be in fixed space to make sure it does not move before the call is made.
"
	finished ifTrue: [^true].
	[	library next_out: output; avail_out: output size; avail_in: 0.
		finished := inflating ifTrue: [self doInflate: true] ifFalse: [self doDeflate: true].
		(action value: output size - library avail_out) and: [ finished not ]
	] whileTrue.
	^finished