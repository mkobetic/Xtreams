"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	(self fillBufferIfRequired: 1) ifFalse: [Incomplete zero raise].
	^buffer get
