private
streamingInsertInto: aWriteStream
	| amount |

	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream insert: amount from: buffer]