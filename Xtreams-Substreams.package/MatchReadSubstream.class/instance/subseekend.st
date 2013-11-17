"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
subseekend
	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		buffer readSkip: buffer readSize]
