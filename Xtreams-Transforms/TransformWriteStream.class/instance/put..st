"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
put: anObject
	incompleteCount == nil ifFalse: [Incomplete zero raise].

	buffer put: anObject.

	"There is now data in the buffer for the drain to read"
	readReady signal.
	writeReady wait
