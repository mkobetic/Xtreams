"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
get
	[outputBuffer hasDataToRead or: [substreamAtEnd]] whileFalse: [self gobble].
	outputBuffer hasDataToRead ifFalse: [Incomplete zero raise].
	^outputBuffer get