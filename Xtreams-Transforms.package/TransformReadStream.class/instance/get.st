"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	(self fillBufferIfRequired: 1) ifFalse: [Incomplete zero raise].
	^buffer get