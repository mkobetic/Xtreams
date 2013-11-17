"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteInto: aWriteStream
	| amount count |
	count := 0.
	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream write: amount from: buffer.
		count := count + amount ].
	^count
