"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
input: anInput output: anOutput
	input := anInput.
	inputUnsignedLong := input interpreting: #unsignedLong_le.

	output := anOutput.
	outputUnsignedLong := output interpreting: #unsignedLong_le.

	"Negotiate version. If our version is less than their version, we expect them to be nice to us or terminate the connection. If our version is more than their version, we should be nice to them and only use what they know."
	self transmitProtocolVersion.
	self processProtocolVersion.

	"Start handling packets receiving."
	process := [self process] newProcess.
	process name: (Processor activeProcess name ifNil: [Processor activeProcess identityHash printString]), ' receiving'.
	process resume