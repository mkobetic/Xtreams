"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	writingSemaphore signal.
	closed ifTrue: [Incomplete zero raise].
	readingSemaphore wait.
	^current