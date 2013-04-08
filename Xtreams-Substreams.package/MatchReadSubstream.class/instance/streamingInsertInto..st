"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsertInto: aWriteStream
	| amount |

	[outputBuffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[outputBuffer hasDataToRead ifFalse: [self gobble].
		amount := outputBuffer readSize.
		aWriteStream insert: amount from: outputBuffer]