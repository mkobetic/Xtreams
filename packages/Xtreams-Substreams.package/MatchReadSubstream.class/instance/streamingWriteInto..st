private
streamingWriteInto: aWriteStream
	| amount count |
	count := 0.
	[buffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[buffer hasDataToRead ifFalse: [self gobble].
		amount := buffer readSize.
		aWriteStream write: amount from: buffer.
		count := count + amount ].
	^count