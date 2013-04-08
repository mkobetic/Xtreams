"
notice: Copyright (c) 2011 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private - receiving
"
process: type
	type = ChannelOpen ifTrue: [^self processChannelOpen].
	type = ChannelClose ifTrue: [^self processChannelClose].
	type = ChannelMore ifTrue: [^self processChannelMore].
	self processChannelData: type