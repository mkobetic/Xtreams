"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
put: anObject
	incompleteCount == nil ifFalse: [Incomplete zero raise].

	buffer put: anObject.

	"There is now data in the buffer for the drain to read"
	readReady signal.
	writeReady wait
