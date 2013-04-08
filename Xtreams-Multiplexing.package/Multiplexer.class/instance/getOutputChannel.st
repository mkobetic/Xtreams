"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
getOutputChannel
	"Get a new output channel. This will initiate an input channel on the remote side."
	"^		<MultiplexWriteStream>	new write channel substream"

	^self nextIdentityDo: [:id |
		self transmitChannelOpen: id.
		MultiplexWriteSubstream on: output multiplexer: self id: id].