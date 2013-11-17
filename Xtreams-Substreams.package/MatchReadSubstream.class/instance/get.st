"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	buffer hasDataToRead ifTrue: [^buffer get].
	substreamAtEnd ifTrue: [Incomplete zero raise].

	self gobble.
	buffer hasDataToRead ifFalse: [Incomplete zero raise].
	^buffer get
