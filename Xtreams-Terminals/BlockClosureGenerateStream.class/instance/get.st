"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
get
	writingSemaphore signal.
	closed ifTrue: [Incomplete zero raise].
	readingSemaphore wait.
	^current
