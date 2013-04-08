"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - transmitting
"
transmitProtocolVersion
	self log: ['transmit protocol version: ', ProtocolVersion printString].
	outputMutex critical: [output put: ProtocolVersion; flush]