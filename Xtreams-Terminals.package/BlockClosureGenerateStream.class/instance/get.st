"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	writingSemaphore signal.
	closed ifTrue: [Incomplete zero raise].
	readingSemaphore wait.
	^current
