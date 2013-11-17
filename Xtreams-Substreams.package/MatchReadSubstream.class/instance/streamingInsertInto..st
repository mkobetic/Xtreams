"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	| amount |

	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream insert: amount from: buffer]
